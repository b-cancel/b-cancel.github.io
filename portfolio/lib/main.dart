//flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//plugins
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart' as drag;
import 'package:portfolio/region/sliverRegion.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bot_toast/bot_toast.dart';

//internal: sections
import 'package:portfolio/bodies/aboutMe.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/hardSkills.dart';
import 'package:portfolio/bodies/projects.dart';
import 'package:portfolio/bodies/softSkills.dart';
import 'package:portfolio/bodies/work.dart';
import 'package:portfolio/utils/platformChecker.dart';

//internal: other
import 'package:portfolio/utils/scrollToTop.dart';

//other
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //scroll to top function
  final ScrollController scrollController = new ScrollController();
  final ValueNotifier<bool> onTop = new ValueNotifier(true);
  final ValueNotifier<double> overScroll = new ValueNotifier<double>(0);

  //If we scroll down have the scroll up button come up
  updateOnTopValue() {
    ScrollPosition position = scrollController.position;
    //double currentOffset = scrollController.offset;

    //update overscroll to cover pill bottle if possible
    double curr = position.pixels;
    double max = position.maxScrollExtent;
    overScroll.value = (curr < max) ? 0 : curr - max;

    //Determine whether we are on the top of the scroll area
    if (curr <= position.minScrollExtent) {
      onTop.value = true;
    } else {
      onTop.value = false;
    }

    //remove toast when pop up
    BotToast.cleanAll();
  }

  //init
  @override
  void initState() {
    //super init
    super.initState();

    //show or hide the to top button
    scrollController.addListener(updateOnTopValue);
  }

  //dipose
  @override
  void dispose() {
    //remove listener
    scrollController.removeListener(updateOnTopValue);

    //super dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sliverSections = [
      SliverToBoxAdapter(
        child: NameTitle(),
      ),
      SliverRegion(
        title: "About Me",
        body: Padding(
          padding: EdgeInsets.only(
            right: 16,
          ),
          child: AboutMeBody(),
        ),
        initiallyOpened: true,
        leftSpacing: true,
      ),
      /*
      SliverRegion(
        title: "Hard Skills",
        body: HardSkillsBody(),
      ),
      SliverRegion(
        title: "Soft Skills",
        body: SoftSkillsBody(),
        leftSpacing: true,
      ),
      SliverRegion(
        title: "Work Experience",
        body: WorkExperienceBody(),
      ),
      SliverRegion(
        title: "Projects",
        body: ProjectsBody(),
      ),
      */
      SliverRegion(
        title: "References",
        body: ReferencesBody(),
        initiallyOpened: true,
      ),
      SliverRegion(
        title: "Contact Me",
        body: ContactMeBody(),
        initiallyOpened: true,
        leftSpacing: true,
      ),
      SliverToBoxAdapter(
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
      )),
      SliverFillRemaining(
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
      ),
    ];

    //build
    return Scaffold(
      backgroundColor: MyApp.bodyColor,
      body: Stack(
        children: <Widget>[
          //section sliver padding
          //22 + 4 + 24
          SafeArea(
            //NOTE: Flutter has 2 options
            //1. ScrollBar (but you cant drag it)
            //2. CupertinoScrollBar (but you cant click to travel)
            child: DraggableScrollbar(
              alwaysVisibleScrollThumb: true,
              backgroundColor: Colors.red,
              heightScrollThumb: 48,
              scrollThumbBuilder: (
                Color backgroundColor,
                Animation<double> thumbAnimation,
                Animation<double> labelAnimation,
                double height, {
                BoxConstraints labelConstraints,
                Text labelText,
              }) {
                return Container(
                  height: height,
                  width: 20.0,
                  color: backgroundColor,
                );
              },
              controller: scrollController,
              child: CustomScrollView(
                controller: scrollController,
                slivers: sliverSections,
              ),
            ),
          ),
          ScrollToTopButton(
            onTop: onTop,
            overScroll: overScroll,
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}

class NameTitle extends StatelessWidget {
  const NameTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> theText = wrappableText(
      "O:\\User\\I_AM_",
      "\\",
    );
    theText.add(
      DefaultTextStyle(
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(4, 0),
              child: Text(
                " Bryan_Cancel ",
                style: TextStyle(
                  color: MyApp.highlightPink,
                ),
              ),
            ),
            Text(
              " Bryan_Cancel ",
              style: TextStyle(
                color: MyApp.highlightGreen,
              ),
            ),
          ],
        ),
      ),
    );
    theText.addAll(
      wrappableText(
        "> echo \"yes... like cancel my order of fries :P\"",
        " ",
      ).toList(),
    );

    //build
    return Material(
      color: MyApp.inactiveTabColor,
      elevation: 4,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            bottom: 16,
          ),
          child: DefaultTextStyle(
            style: GoogleFonts.robotoMono(
              fontSize: 12,
              color: Colors.white,
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: theText,
            ),
          ),
        ),
      ),
    );
  }
}

List<Widget> wrappableText(String text, String splitChar) {
  List<String> bits = text.split(splitChar);
  List<Widget> widgets = new List<Widget>();
  for (int i = 0; i < bits.length; i++) {
    bool isLast = (i == bits.length - 1);
    widgets.add(
      Text(
        bits[i] + (isLast ? "" : splitChar),
      ),
    );
  }
  return widgets;
}