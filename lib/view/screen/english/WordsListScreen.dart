import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/data/common/AppDatabase.dart';
import 'package:flutter_example/data/word/Word.dart';
import 'package:flutter_example/data/word/WordStorage.dart';
import 'package:flutter_example/view/screen/english/WordDetailsScreen.dart';
import 'package:flutter_example/view/styles/edge/Edges.dart';


enum WordListType {
  COMPLETED, STUDY, ALL
}


class WordsListState extends State<WorldsListScreen> with WordDelegate {

  final audioPlayer = AudioPlayer();
  final WordStorage storage;
  final WordListType type;

  List<Word> _words = List();

  WordsListState(this.storage, this.type);


  @override
  void initState() {
    super.initState();
    getWorlds();
  }

  void getWorlds() {
    switch (type) {
      case WordListType.ALL:
        storage.findAll()
            .asStream()
            .listen((words) => setState(() => _words.addAll(words)));
        break;
      case WordListType.COMPLETED:
        storage.findCompleted()
            .asStream()
            .listen((words) => setState(() => _words.addAll(words)));
        break;
      case WordListType.STUDY:
        storage.findStudy()
            .asStream()
            .listen((words) => setState(() => _words.addAll(words)));
        break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Словарь"),
        ),
        body: ListView.separated(
          padding: EdgeInsets.only(top: Edges.Base, bottom: Edges.Base),
          separatorBuilder: (context, index) => Divider(
            color: Colors.black12,
          ),
          itemCount: _words.length,
          itemBuilder: (context, index) => GestureDetector(
            child:  WorldListItem(_words[index], this),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorldDetailsScreen(_words[index]))
            ),
          ),
        )
    );
  }

  @override
  void soundWord(Word word) {
    audioPlayer.play(word.soundUrl)
        .asStream()
        .listen((result) => print("Complete"));
  }

  @override
  void toggleComplete(Word word) {
    storage.updateIsCompleted(word.id, !word.isCompleted);
  }
}

class WorldsListScreen extends StatefulWidget {

  final WordListType type;

  final WordStorage storage = WordStorage(AppDatabase.shared);

  WorldsListScreen(this.type);

  @override
  State<StatefulWidget> createState() {
    return WordsListState(storage, type);
  }

}


class WorldListItem extends StatefulWidget {

  final Word _item;
  final WordDelegate _delegate;

  WorldListItem(this._item, this._delegate);

  @override
  State<StatefulWidget> createState() {
    return WordState(_item, this._delegate);
  }

}

mixin WordDelegate {
  void soundWord(Word word);
  void toggleComplete(Word word);
}

class WordState extends State<WorldListItem> {

  final Word _item;
  bool isVisibleTranslate = false;
  final WordDelegate _delegate;

  WordState(this._item, this._delegate) {
    print(_item.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleComplete,
      child: Container(
        padding: EdgeInsets.only(left: Edges.Base,
            right: Edges.Base,
            top: Edges.BaseLowerHalf,
            bottom: Edges.BaseLowerHalf),
        child: Row(
          children: <Widget>[
            Flexible(
                child: Row(
                    children: <Widget>[
                      new Stack(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: FadeInImage.assetNetwork(
                                    placeholder: "images/person.jpeg",
                                    image: _item.imageUrl,
                                    fit: BoxFit.cover
                                ),
                              ),
                            ),
                            _item.isCompleted
                                ? new Positioned(  // draw a red marble
                                top: 0.0,
                                right: 0.0,
                                child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: Colors.lightGreen,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Icon(Icons.check, size: 12)
                                )
                            )
                                : SizedBox()
                          ]
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Edges.Base, right: Edges.Base),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _item.word.toLowerCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,

                              ),
                            ),
                            Visibility(
                              child: Text(
                                  _item.translate,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14
                                  )
                              ),
                              visible: isVisibleTranslate,
                            )
                          ],
                        ),
                      ),
                    ]
                )
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: isVisibleTranslate ? Icon(Icons.visibility_off) : Icon(
                      Icons.visibility),
                  color: Colors.black54,
                  onPressed: _toggleTranslate,
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  color: Colors.black54,
                  onPressed: () => _delegate.soundWord(_item),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _toggleTranslate() {
    setState(() {
      isVisibleTranslate = !isVisibleTranslate;
    });
  }

  void _toggleComplete() {
    setState(() {
      _delegate.toggleComplete(_item);
      _item.isCompleted = !_item.isCompleted;
    });
  }
}