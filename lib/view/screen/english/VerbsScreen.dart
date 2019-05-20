

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_example/data/common/AppDatabase.dart';
import 'package:flutter_example/data/verb/Verb.dart';
import 'package:flutter_example/data/verb/VerbStorage.dart';
import 'package:flutter_example/view/styles/edge/Edges.dart';


class VerbsScreen extends StatefulWidget {

  VerbsStorage storage = VerbsStorage((AppDatabase.shared));

  @override
  State<StatefulWidget> createState() {
    return VerbsListState(storage);
  }

}


enum VerbScreenState {
  QUESTION, CORRECT, INCORRECT
}


class VerbsListState extends State<VerbsScreen> {

  final VerbsStorage storage;
  List<Verb> _words = List();
  List<Verb> _usedWords = List();
  Random _random = Random();

  VerbForm _fixedForm;
  VerbForm _selectedForm;
  Verb _word;
  VerbScreenState _screenState = VerbScreenState.QUESTION;

  VerbsListState(this.storage);

  @override
  void initState() {
    super.initState();
    getWorlds();
  }

  void getWorlds() {
    storage.findAll()
        .asStream()
        .listen((words) => setState(() {
          _words.addAll(words);
          updateWord();
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Неправильные глаголы"),
        ),
        body: Container(
          margin: EdgeInsets.all(Edges.BaseGraterQuarter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: Edges.Base,
                    right: Edges.Base,
                    top: 48,
                    bottom: 48
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _word != null ? _word.getVerb(_fixedForm) : "Загрузка...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                      Text(
                        _word != null ? _word.translate : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Edges.Base,
              ),
              MaterialButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    _screenState == VerbScreenState.QUESTION ? 'Present'.toUpperCase() : _word.getVerb(VerbForm.PRESENT),
                    textAlign: TextAlign.center,
                  ),
                ),
                padding: EdgeInsets.all(16),
                onPressed: _screenState == VerbScreenState.QUESTION ? () => checkVerb(VerbForm.PRESENT) : null,
                color: getButtonColor(VerbForm.PRESENT),
                textColor: Colors.white,
                disabledTextColor: Colors.white,
              ),
              SizedBox(
                height: Edges.Base,
              ),
              MaterialButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    _screenState == VerbScreenState.QUESTION ? 'Past'.toUpperCase() : _word.getVerb(VerbForm.PAST),
                    textAlign: TextAlign.center,
                  ),
                ),
                padding: EdgeInsets.all(16),
                onPressed: _screenState == VerbScreenState.QUESTION ? () => checkVerb(VerbForm.PAST) : null,
                color: getButtonColor(VerbForm.PAST),
                textColor: Colors.white,
                disabledTextColor: Colors.white,
              ),
              SizedBox(
                height: Edges.Base,
              ),
              MaterialButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    _screenState == VerbScreenState.QUESTION ? 'Perfect'.toUpperCase() : _word.getVerb(VerbForm.PERFECT),
                    textAlign: TextAlign.center,
                  ),
                ),
                padding: EdgeInsets.all(16),
                onPressed:  _screenState == VerbScreenState.QUESTION ? () => checkVerb(VerbForm.PERFECT) : null,
                color: getButtonColor(VerbForm.PERFECT),
                textColor: Colors.white,
                disabledTextColor: Colors.white,
              ),
              SizedBox(
                height: Edges.Base,
              ),
              _screenState == VerbScreenState.QUESTION
                ? Container()
                : MaterialButton(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Next'.toUpperCase(),
                    textAlign: TextAlign.center,
                  ),
                ),
                padding: EdgeInsets.all(16),
                onPressed: updateWord,
                color: Colors.white,
                textColor: Colors.black,
              )
            ],
          )
        )
    );
  }

  void checkVerb(VerbForm form) {
    setState(() {
      var fixedVerb = _word.getVerb(_fixedForm);
      var selectedVerb = _word.getVerb(form);
      var isEqualsVerbs = fixedVerb == selectedVerb;

      var isCorrect = _fixedForm == form || isEqualsVerbs;

      if (isEqualsVerbs) {
        _fixedForm = form;
      }
      _screenState = isCorrect ? VerbScreenState.CORRECT : VerbScreenState.INCORRECT;
      _selectedForm = form;
    });
  }

  void updateWord() {
    setState(() {
      _selectedForm = null;
      _screenState = VerbScreenState.QUESTION;
      var newWord;
      do {
        newWord = _words[_random.nextInt(_words.length)];
      } while(_usedWords.contains(newWord));
      _word = newWord;
      _fixedForm = newWord.getFrom();
    });
  }


  Color getButtonColor(VerbForm from) {
    if (_screenState == VerbScreenState.QUESTION) {
      return Colors.black;
    }

    if (_screenState == VerbScreenState.CORRECT) {
      if (from == _fixedForm) {
        return Colors.lightGreen;
      } else {
        return Colors.black;
      }
    }

    if (_screenState == VerbScreenState.INCORRECT) {
      if (from == _fixedForm) {
        return Colors.lightGreen;
      } else if (from == _selectedForm) {
        return Colors.red;
      } else {
        return Colors.black;
      }
    }
  }
}
