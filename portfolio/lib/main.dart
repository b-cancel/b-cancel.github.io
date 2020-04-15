//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/regularSection.dart';

//plugins
import 'package:portfolio/sliverSection.dart';
import 'package:google_fonts/google_fonts.dart';

//other
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

  //from before
  static Color highlightGreen = Color(0xFF00FBB1);
  static Color highlightPink = Color(0xFFB0167A);
  static Color oldPurple = const Color(0xFFAB7FFA);
  static Color oldGrey = Color(0xFF808080);

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
    List<Widget> sliverSections = [
      SliverToBoxAdapter(
        child: NameTitle(),
      ),
      SliverSection(
        title: "About Me",
        body: TestBody(),
        initiallyOpened: true,
      ),
      SliverSection(
        title: "Hard Skills",
        //education
        //certifications
        body: Column(
          children: [
            RegularSection(
              title: "Formal Education",
              titleColor: MyApp.yellowText,
              body: Column(
                children: <Widget>[
                  Text("college stuff"),
                  RegularSection(
                    title: "Coursework",
                    titleColor: MyApp.orangeText,
                    body: Column(
                      children: <Widget>[
                        Text("c1"),
                        
                        Text("c2"),
                      ],
                    ),
                  ),
                  Text("high school stuff"),
                ],
              ),
            ),
            RegularSection(
              title: "Languages/Frameworks beep boop bap",
              titleColor: MyApp.greenText,
              body: Column(
                children: <Widget>[
                  Text("all languages with paired framework with profficiency"),
                ],
              ),
            ),
            RegularSection(
              title: "Tools",
              titleColor: MyApp.yellowText,
              body: Column(
                children: <Widget>[
                  Text("IDEs, version control"),
                ],
              ),
            ),
            RegularSection(
              title: "Certifications",
              titleColor: MyApp.blueText,
              body: Column(
                children: <Widget>[
                  Text("adobe stuff"),
                ],
              ),
            ),
          ]
        ),
      ),
      SliverSection(
        title: "Soft Skills",
        //education
        //certifications
        body: Column(
          children: [
            Text("languages, leadership, project planing, problem solving, etc"),
          ]
        ),
      ),
      //TODO: add soft skills
      //TODO: relevant coursework
      //TODO: add language, frameworks, etc
      //TODO: add work experience
      SliverSection(
        title: "Projects",
        body: TestBody(),
      ),
      SliverSection(
        title: "Endorsements",
        body: TestBody(),
      ),
      SliverSection(
        title: "Contact Me",
        body: TestBody(),
        initiallyOpened: true,
      ),
    ];

    //build
    return Scaffold(
      backgroundColor: MyApp.bodyColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: sliverSections,
        ),
      ),
    );
  }
}

class TestBody extends StatelessWidget {
  const TestBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text("body\n\n\n\n\n\n\n\n\n\n\n\n\n\nend"),
    );
  }
}

class NameTitle extends StatelessWidget {
  const NameTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyApp.headerColor,
      elevation: 4,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: DefaultTextStyle(
          style: GoogleFonts.robotoMono(
            fontSize: 12,
            color: Colors.white,
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              Text(
                "O:\\User\\I_AM_",
              ),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                child: Stack(children: [
                  Transform.translate(
                    offset: Offset(4, 0),
                    child: Text(
                      "Bryan_Cancel",
                      style: TextStyle(
                        color: MyApp.highlightPink,
                      ),
                    ),
                  ),
                  Text(
                    "Bryan_Cancel",
                    style: TextStyle(
                      color: MyApp.highlightGreen,
                    ),
                  ),
                ]),
              ),
              Text(
                " > echo \"yes... like cancel my order of fries :P\"",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
