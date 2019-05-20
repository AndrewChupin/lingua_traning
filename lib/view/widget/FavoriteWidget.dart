import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteStateModel {
  final int starsCount;
  final bool isChecked;

  FavoriteStateModel({this.starsCount, this.isChecked});

  FavoriteStateModel toggle() {
    return FavoriteStateModel(
      starsCount: this.isChecked
          ? starsCount - 1
          : starsCount + 1,
      isChecked: !this.isChecked
    );
  }
}

class FavoriteWidget extends StatefulWidget {

  final FavoriteStateModel model;

  FavoriteWidget({this.model});

  @override
  State<StatefulWidget> createState() {
    return _FavoriteState(model: model);
  }
}

class _FavoriteState extends State<FavoriteWidget> {

  FavoriteStateModel model;

  _FavoriteState({this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: IconButton(
            icon: (model.isChecked ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggle,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text("${model.starsCount}"),
          ),
        ),
      ],
    );
  }

  void _toggle() {
    setState(() {
      model = model.toggle();
    });
  }
}
