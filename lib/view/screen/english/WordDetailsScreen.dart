import 'package:flutter/material.dart';
import 'package:flutter_example/data/word/Word.dart';
import 'package:flutter_example/view/styles/edge/Edges.dart';


class WorldDetailsScreen extends StatelessWidget {

  final Word _word;

  WorldDetailsScreen(this._word);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_word.word),
      ),
      body: Container(
        padding: EdgeInsets.all(Edges.Base),
        child: Column(
          children: <Widget>[
            Image.network(
                _word.imageUrl,
                width: 640,
                height: 360,
            ),
            Text(_word.word),
            Text(_word.transcription),
            Text(_word.translate),
            FloatingActionButton(
                onPressed: null,
                child: Icon(Icons.volume_up),
                backgroundColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}