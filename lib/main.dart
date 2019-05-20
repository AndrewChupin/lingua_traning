import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/domain/human.dart';
import 'package:flutter_example/view/screen/FormScreen.dart';
import 'package:flutter_example/view/screen/SecondScreen.dart';
import 'package:flutter_example/view/screen/english/VerbsScreen.dart';
import 'package:flutter_example/view/screen/english/WordsListScreen.dart';
import 'package:flutter_example/view/styles/edge/Edges.dart';
import 'package:flutter_example/view/widget/HumanWidget.dart';


void main() => runApp(MyApp());

const MaterialColor grey1 = MaterialColor(
  _greyPrimaryValue,
  <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    350: Color(0xFFD6D6D6), // only for raised button while pressed in light theme
    400: Color(0xFFBDBDBD),
    500: Color(_greyPrimaryValue),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    850: Color(0xFF303030), // only for background color in dark theme
    900: Color(0xFF212121),
  },
);

const int _greyPrimaryValue = 0xFF212121;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AudioPlayer.logEnabled = true;
    return MaterialApp(
      title: 'Flutter Demo',
      showSemanticsDebugger: false,
      theme: ThemeData(
        fontFamily: "Roboto",
        primarySwatch: grey1,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }


}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  List<Human> _humans = List();

  double _top = 0;
  Animation<double> animation;
  AnimationController controller;
  Tween tween = Tween<double>(begin: 10.0, end: 180.0);

  @override
  void initState() {
    super.initState();
    //getHumans();

    controller = new AnimationController(
        vsync: this,
        duration: new Duration(seconds: 2)
    );
    controller.value = 0;
  }

  double _childHeight(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject();
    return renderBox.size.height;
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      width: 700,
      height: 300,
      color: Colors.green,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Edges.Base,
            ),
            MaterialButton(
              child: SizedBox(
                width: double.infinity,
                child: Text("All"),
              ),
              padding: EdgeInsets.all(16),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorldsListScreen(WordListType.ALL))
                );
              },
              color: Colors.black87,
              textColor: Colors.white,
              disabledTextColor: Colors.white,
            ),
            SizedBox(
              height: Edges.Base,
            ),
            MaterialButton(
              child: SizedBox(
                width: double.infinity,
                child: Text("Completed"),
              ),
              padding: EdgeInsets.all(16),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorldsListScreen(WordListType.COMPLETED))
                );
              },
              color: Colors.black87,
              textColor: Colors.white,
              disabledTextColor: Colors.white,
            ),
            SizedBox(
              height: Edges.Base,
            ),
            MaterialButton(
              child: SizedBox(
                width: double.infinity,
                child: Text("Study"),
              ),
              padding: EdgeInsets.all(16),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WorldsListScreen(WordListType.STUDY))
                );
              },
              color: Colors.black87,
              textColor: Colors.white,
              disabledTextColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }


  void getHumans() async {
    var stream = await fetchHumans();
    stream.listen((humans) => setState(() =>
        _humans.addAll(humans))
    );
  }

}
