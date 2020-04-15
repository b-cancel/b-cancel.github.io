import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //main
  static Color headerColor = Color(0xFF3C3C3C);
  static Color activeTabColor = Color(0xFF1E1E1E);
  static Color inactiveTabColor = Color(0xFF2D2D2D);
  static Color besideTabColor = Color(0xFF252526);
  static Color bodyColor = activeTabColor;

  //menu
  static Color sideMenuBackground = Color(0xFF333333);
  static Color menuIconInActive = Color(0xFF7E7E7E);
  static Color menuSectionClosed = Color(0xFF383838);
  static Color menuSectionOpen = Color(0xFF252526);

  //color
  static Color lightBlueText = Color(0xFF6FB5C6);
  static Color blueText = Color(0xFF2A53AB);
  static Color orangeText = Color(0xFFBA7955);
  static Color yellowText = Color(0xFFACBB8E);
  static Color lightGreenText = Color(0xFF3AAA8A);
  static Color greenText = Color(0xFF5C7231);
  static Color pinkText = Color(0xFF9D5660);
  static Color redText = Color(0xFFCD3D33);
  static Color greyText = Color(0xFF646465);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bryan\'s Portfolio',
      theme: ThemeData(
        //dark mode default
        brightness: Brightness.dark,
        //none of that ugly green
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app bar here"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Text("content and stuff")
      ),
    );
  }
}
