//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:google_fonts/google_fonts.dart';

//internal: sections
import 'package:portfolio/bodies/aboutMe.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/hardSkills.dart';
import 'package:portfolio/bodies/projects.dart';
import 'package:portfolio/bodies/softSkills.dart';
import 'package:portfolio/bodies/work.dart';

//internal: other
import 'package:portfolio/region/sliverRegion.dart';
import 'package:portfolio/utils/wrappedText.dart';
import 'package:portfolio/utils/scrollToTop.dart';
import 'package:portfolio/main.dart';

//widgets
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
    print("max: " + max.toString());

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
  TopIntro(),
  SliverAppBar(
    pinned: true,
    backgroundColor: MyApp.inactiveTabColor,
    title: DefaultTextStyle(
      style: GoogleFonts.robotoMono(
        color: Colors.white,
        fontSize: MyApp.h1,
      ),
      child: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(3, 0),
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
  ),
  BottomIntro(),
  SliverRegion(
    title: "About Me", //profile icon
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
        title: "Skills", //tools icon
        body: SoftSkillsBody(),
        leftSpacing: true,
      ),
      SliverRegion(
        title: "Work Experience", //suit case 
        body: WorkExperienceBody(),
      ),
      SliverRegion(
        title: "Projects", //light bulb
        body: ProjectsBody(),
      ),
      */
  SliverRegion(
    title: "References", //thumbs up
    body: ReferencesBody(),
    initiallyOpened: true,
  ),
  SliverRegion(
    title: "Contact Me", //contact card icon
    body: ContactMeBody(),
    initiallyOpened: true,
    leftSpacing: true,
  ),
  RightBottom(),
  FillRemaining(),
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