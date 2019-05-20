import 'package:flutter/material.dart';


class CardScreen extends StatelessWidget {

  var _list = List(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),
      body: Container(
        child: PageView(
          children: _list.map((item) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    child: Image.asset(
                      "images/lake.jpg",
                      width: 640,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Alps. Situated 1,578 meters above sea level, it is one of the ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),)
                ],
              )
          ).toList(),
        ),
      ),
    );
  }
}