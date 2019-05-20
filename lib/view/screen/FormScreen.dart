import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/view/screen/CardScreen.dart';
import 'package:flutter_example/view/styles/edge/Edges.dart';


class FormScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select the form"),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(Edges.Base),
            child: Column(
              children: <Widget>[
                createTextField(
                    label: "Имя",
                    helper: "Имя может быть произвольной длины",
                    withPadding: false,
                    autoFocus: true
                ),
                createTextField(
                    label: "Фамилия",
                    helper: "Фамилия может быть произвольной длины"
                ),
                createTextField(
                    label: "Отчество",
                    helper: "Отчество может быть произвольной длины"
                ),
                createTextField(
                    label: "Год рождения",
                    helper: "Год рождения должн привышать 4 сивола",
                    maxLength: 4,
                    type: TextInputType.number
                ),
                Padding(
                    padding: EdgeInsets.only(top: Edges.BaseGraterSingle),
                    child: MaterialButton(
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Raised Button'.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      onPressed:  () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CardScreen()),
                        );
                      },
                      color: Colors.black,
                      textColor: Colors.white,
                    ),
                )
              ],
            ),
          ),
        )
    );
  }


  Padding createTextField({String label, helper: "", withPadding: true, type: TextInputType.text, maxLength: 0, autoFocus: false}) => Padding(
    padding: withPadding
        ? EdgeInsets.only(top: Edges.BaseLowerHalf)
        : EdgeInsets.only(top: Edges.Zero),
    child: TextField(
        textCapitalization: TextCapitalization.words,
        autofocus: autoFocus,
        maxLength: maxLength > 0
            ? maxLength
            : null,
        style: TextStyle(
            fontSize: 16,
            color: Colors.black
        ),
        decoration: InputDecoration(
            labelText: label,
            helperText: helper
        ),
        keyboardType: type,
        cursorWidth: 1,
        cursorColor: Colors.black
    ),
  );
}