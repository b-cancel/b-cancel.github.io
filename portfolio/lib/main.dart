//flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//plugins
import 'package:bot_toast/bot_toast.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';

//internal
import 'package:portfolio/utils/wrappedText.dart';
import 'package:portfolio/home.dart';

List<IconData> iconsToUseLater = [
  //company and school
  PortfolioIcons.building_filled, //company name
  PortfolioIcons.school, //school name
  PortfolioIcons.info_circle, //description
  //contact
  PortfolioIcons.address_card, //v-card
  //project types
  PortfolioIcons.location_on, //location
  PortfolioIcons.mobile, //apps
  PortfolioIcons.desktop, //websites
  PortfolioIcons.gamepad, //games
  //language
  PortfolioIcons.volume_up, //speak
  PortfolioIcons.book_reader, //read
  PortfolioIcons.pen_alt, //write
  //sections closed
  PortfolioIcons.user,
  PortfolioIcons.award,
  PortfolioIcons.thumbs_up,
  PortfolioIcons.video_1, //filmn
];

//other
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //used everywhere
  static TextStyle robotoMono = TextStyle(
    fontFamily: 'RobotoMono',
    color: Colors.white,
  );

  //headers
  static const double h1 = 32;
  static const double h2 = 28;
  static const double h3 = 24;
  //6 units of differenc between stuff that
  //should be as header and stuff that shouldn't
  static const double h4 = 18;
  static const double h5 = 14;
  //tiny shoudn't be any tinier that 12 pt
  static const double h6 = 12;

  //link color
  static const Color lightLinkColor = highlightGreen;
  static const Color darkLinkColor = Color(0xFF1A0DAB);

  //main
  static const Color headerColor = Color(0xFF3C3C3C);
  static const Color activeTabColor = Color(0xFF1E1E1E);
  static const Color inactiveTabColor = Color(0xFF2D2D2D);
  static const Color besideTabColor = Color(0xFF252526);
  static const Color bodyColor = activeTabColor;
  static const Color scrollBarColor = Color(0xFF424242);

  //menu
  static const Color sideMenuBackground = Color(0xFF333333);
  static const Color menuIconInActive = Color(0xFF7E7E7E);
  static const Color menuSectionClosed = Color(0xFF383838);
  static const Color menuSectionOpen = Color(0xFF252526);

  //color
  static const Color lightBlueText = Color(0xFF6FB5C6);
  static const Color blueText = Color(0xFF2A53AB);
  static const Color orangeText = Color(0xFFBA7955);
  static const Color yellowText = Color(0xFFACBB8E);
  static const Color lightGreenText = Color(0xFF3AAA8A);
  static const Color greenText = Color(0xFF5C7231);
  static const Color pinkText = Color(0xFF9D5660);
  static const Color redText = Color(0xFFCD3D33);
  static const Color greyText = Color(0xFF646465);

  //from before
  static const Color highlightGreen = Color(0xFF00FBB1);
  static const Color highlightPink = Color(0xFFB0167A);
  static const Color oldPurple = const Color(0xFFAB7FFA);
  static const Color oldGrey = Color(0xFF808080);
  static const Color oldOrange = Color(0xFFFA951F);

  //gallery
  static const Color galleryBackground = Color(0xFF001F33);
  static const Color galleryBorder = Color(0xFF007ACC);
  static const Color galleryTopRibbon =  Color(0xFF1E1E1E);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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

//used to place where the scroll bar starts
//and to determine if we should hide the joke
double topIntroHeight = 8.0 + 16;
class TopIntro extends StatelessWidget {
  const TopIntro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: MyApp.inactiveTabColor,
        child: DefaultTextStyle(
          style: MyApp.robotoMono.copyWith(
            color: Colors.white,
            fontSize: MyApp.h6,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 8,
              ),
              child: WrappedText(
                "O:\\User\\I_AM_",
                pattern: "\\",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    Key key,
    this.isTiny: false,
  }) : super(key: key);

  final bool isTiny;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: MyApp.robotoMono.copyWith(
        color: Colors.white,
        fontSize: isTiny ? MyApp.h3 : MyApp.h1,
      ),
      child: Transform.translate(
        offset: Offset(5, 0),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(3, 2),
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
          ],
        ),
      ),
    );
  }
}

class Joke extends StatelessWidget {
  const Joke({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: MyApp.robotoMono.copyWith(
        color: Colors.white,
        fontSize: MyApp.h5,
        height: 1,
      ),
      child: WrappedText(
        "> echo \"yes... like cancel my order of fries :P\"",
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
        ),
        child: Center(
          child: DefaultTextStyle(
            style: MyApp.robotoMono.copyWith(
              fontSize: MyApp.h6,
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
            PortfolioIcons.mobile,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}