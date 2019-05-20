import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/domain/human.dart';


class HumanWidget extends StatelessWidget {

  final Human _human;

  HumanWidget(this._human);

  Color getColorByAge(int age) => Color.lerp(Colors.red, Colors.green, age/99);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(_human.age.toString()),
        background: Container(color: Colors.black),
        secondaryBackground: Container(color: Colors.red),
        onDismissed: (direct) {
          Scaffold.of(context).hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
          direct == DismissDirection.endToStart
              ? Scaffold.of(context).showSnackBar(SnackBar(content: Text("Swipe Left")))
              : Scaffold.of(context).showSnackBar(SnackBar(content: Text("Swipe Right")));
        },
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              _human.age.toString(),
            ),
            backgroundColor: getColorByAge(_human.age),
          ),
          title: Text(_human.name),
          subtitle: Text(_human.id.toString()),
        )
    );
  }
}
