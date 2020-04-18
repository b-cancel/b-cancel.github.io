//flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//plugins
import 'package:google_fonts/google_fonts.dart';
import 'package:bot_toast/bot_toast.dart';

//internal
import 'package:portfolio/utils/wrappedText.dart';
import 'package:portfolio/home.dart';

//other
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static double h1 = 32;
  static double h2 = 28;
  static double h3 = 24;
  //6 units of differenc between stuff that
  //should be as header and stuff that shouldn't
  static double h4 = 18;
  static double h5 = 14;
  //tiny shoudn't be any tinier that 12 pt
  static double h6 = 12;

  //link color
  static Color lightLinkColor = highlightGreen;
  static Color darkLinkColor = Color(0xFF1A0DAB);

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
  static Color oldOrange = Color(0xFFFA951F);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        title: 'Bryan\'s Portfolio',
        theme: ThemeData(
          //text selection
          textSelectionColor: Colors.blue,
          textSelectionHandleColor: Colors.blue,
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
      ),
    );
  }
}

class TopIntro extends StatelessWidget {
  const TopIntro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: MyApp.inactiveTabColor,
        child: Transform.translate(
          offset: Offset(0, 16),
          child: DefaultTextStyle(
            style: GoogleFonts.robotoMono(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 0,
                ),
                child: WrappedText(
                  "O:\\User\\I_AM_",
                  pattern: "\\",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomIntro extends StatelessWidget {
  const BottomIntro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: MyApp.inactiveTabColor,
        padding: EdgeInsets.only(
          bottom: 16,
        ),
        child: DefaultTextStyle(
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            height: 1,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: WrappedText(
              "> echo \"yes... like cancel my order of fries :P\"",
            ),
          ),
        ),
      ),
    );
  }
}

class RightBottom extends StatelessWidget {
  const RightBottom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(
          top: 16.0,
          //section sliver padding
          left: 22 + 4.0 + 24,
        ),
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Text("All Rights Reserved @ 2020\n"),
                Text("Inspired By IDEs Everywhere"),
                Text("Developed And Designed"),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("by "),
                    Text(
                      "Bryan Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text("using Dart/Flutter"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FillRemaining extends StatelessWidget {
  const FillRemaining({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false, //it should be as small as possible
      fillOverscroll: true, //only if above is false
      child: Opacity(
        opacity: 0.0,
        child: Padding(
          padding: EdgeInsets.all(28.0 + 4),
          child: Icon(
            Icons.adb,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}