import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu/expandingText.dart';
import 'package:portfolio/menu/myWorkTitle.dart';
import 'package:portfolio/menu/sections/software.dart';
import 'package:portfolio/menu/swapingText.dart';
import 'package:portfolio/utils/chips.dart';
import 'package:portfolio/utils/link/openLink.dart';
import 'package:portfolio/utils/wrappedText.dart';

class ResumeInfo extends StatefulWidget {
  const ResumeInfo({
    Key key,
    @required this.minWidth,
    @required this.maxWidth,
  }) : super(key: key);

  final double minWidth;
  final double maxWidth;

  @override
  _ResumeInfoState createState() => _ResumeInfoState();
}

class _ResumeInfoState extends State<ResumeInfo> {
  ScrollController scrollController = new ScrollController();

  hideToasts() {
    BotToast.cleanAll();
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(hideToasts);
  }

  @override
  void dispose() {
    scrollController.removeListener(hideToasts);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //NOTE: can't smart refresh from here and keep the menu scaling as desired
    //also there really is no reason why they would be reloading from here
    //everything should always load in properly
    TextStyle bold = TextStyle(
      fontWeight: FontWeight.bold,
    );

    return SingleChildScrollView(
      controller: scrollController,
      //iOS feel
      physics: BouncingScrollPhysics(),
      //atleast spacing to match name
      padding: EdgeInsets.symmetric(
        horizontal: 0,
        vertical: 0,
      ),
      //children
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //NOTE: we start spreaded when the secation starts open
          ExpandingSection(
            title: "Experience",
            useSpreadingTitle: true,
            startOpen: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwappingSection(
                  title: "Mobile Development and Design (Dart/Flutter)",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("05/2020 -> 08/2020"),
                      Text("Mobile Development and Design (Dart/Flutter)",
                          style: bold),
                      Text("Lawn Buddy – Remote")
                    ],
                  ),
                ),
                SwappingSection(
                  title: "Web Development (Google App Scripts)",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("03/2020 –> 09/2020"),
                      Text("Web Development (Google App Scripts)", style: bold),
                      Text("Lebron Group Land Surveying – Remote")
                    ],
                  ),
                ),
                SwappingSection(
                  title: "Barista",
                  startOpen: false,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("10/2019 –> 05/2020"),
                      Text("Barista", style: bold),
                      Text("Starbucks – Edinburg, TX")
                    ],
                  ),
                ),
                SwappingSection(
                  title: "App Development (Dart / Flutter)",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("05/2018 – 08/2018"),
                      Text("App Development (Dart / Flutter)", style: bold),
                      Text("CleverSolve – Edinburg, TX"),
                      Text("Summer Internship"),
                    ],
                  ),
                ),
                SwappingSection(
                  title: "Web Development and Design",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("07/2017 – 08/2017"),
                      Text("Web Development and Design", style: bold),
                      Text("Lebron Group Land Surveying – Winter Park, FL"),
                    ],
                  ),
                ),
                SwappingSection(
                  title: "Graphic Design and Video Editing",
                  startOpen: false,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("09/2014 – 05/2015"),
                      Text("Graphic Design and Video Editing", style: bold),
                      Text("UT Center for Railway Safety – Edinburg, TX"),
                    ],
                  ),
                ),
                SwappingSection(
                  title: "Graphic Design and Video Editing",
                  startOpen: false,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("09/2013 – 05/2014"),
                      Text("Graphic Design and Video Editing", style: bold),
                      Text("IT Marketing Division at UTPA – Edinburg, TX"),
                      Text("Internship"),
                    ],
                  ),
                ),
                SwappingSection(
                  title: "Robotics Coach",
                  startOpen: false,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("05/2013 – 05/2014"),
                      Text("Robotics Coach", style: bold),
                      Text(
                          "Business Education Technology Academy – Edinburg, TX"),
                      Text("Volunteer"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ExpandingSection(
            title: "Education",
            useSpreadingTitle: true,
            startOpen: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwappingSection(
                  title: "Bachelor of Science in Computer Science, 3.6",
                  startOpen: false,
                  content: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Bachelor of Science in Computer Science"),
                        Text("University of Rio Grande Valley"),
                        Text("May 2019: Cum Laude, 3.6 GPA"),
                        ExpandingSection(
                          title: "Relevant Coursework",
                          startOpen: false,
                          content: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: Chips(
                              wrapped: false,
                              chips: [
                                "Discrete Data Structures",
                                "Algorithms & Data Structures",
                                "Design & Analysis of Algorithms",
                                "Automata, Formal Lang & Comp",
                                "Software Engineering 1 & 2",
                                "Internet Programming",
                                "Intro. to Game Development",
                                "Database Design & Implementation",
                                "Systems Programming",
                                "Computer Architecture",
                                "Object Oriented Programming in C#",
                                "Computer Org & Assembly Lang",
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SwappingSection(
                  title: "High School Diploma, 3.9",
                  startOpen: false,
                  content: IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("High School Distinguished Diploma"),
                        Text("Business Education Technololgy Academy"),
                        Text("May 2014: Magna Cum Laude, 3.9 GPA"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExpandMyWorkOnHover(
            minWidth: widget.minWidth,
            maxWidth: widget.maxWidth,
          ),
          ExpandingSection(
            title: "Software",
            useSpreadingTitle: true,
            startOpen: true,
            content: SoftwareContent(),
          ),
          ExpandingSection(
            title: "Certifications",
            useSpreadingTitle: true,
            startOpen: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandingSection(
                  title: "Adobe CS6 Suite",
                  content: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Chips(
                      chips: [
                        "Photoshop",
                        "Premiere Pro",
                        "Dreamweaver",
                        "Illustrator",
                        "InDesign",
                        "Flash",
                      ],
                    ),
                  ),
                ),
                ExpandingSection(
                  title: "CIW Web Foundation Associate",
                  startOpen: false,
                  content: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Chips(
                      chips: [
                        "Network Technology Associate",
                        "Site Development",
                        "Internet Business",
                      ],
                    ),
                  ),
                ),
                ExpandingSection(
                  title: "IC3 GS3 Series",
                  startOpen: false,
                  content: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Chips(
                      chips: [
                        "Living Online",
                        "Key Applications",
                        "Computing Fundamentals",
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ExpandingSection(
            title: "Other",
            useSpreadingTitle: true,
            startOpen: false,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpandingSection(
                  title: "Leadership",
                  startOpen: true,
                  content: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "2013 – 2014",
                          style: bold,
                        ),
                        WrappedText(
                            "Treasurer, for the Technology Student Association"),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "2012 – 2014",
                                style: bold,
                              ),
                              WrappedText(
                                  "Robotics Curriculum Precursor, at BETA"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ExpandingSection(
                  title: "Awards",
                  startOpen: true,
                  content: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "2013 – 2014",
                          style: bold,
                        ),
                        WrappedText(
                            "- TSA Vex Robotics: 1st Regionals 7th State"),
                        WrappedText(
                            "- TSA Web Design: 3rd State 4th Nationals"),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "2012 – 2013",
                                style: bold,
                              ),
                              WrappedText("- TSA Member of the Year"),
                              WrappedText(
                                  "- Technology Problem Solving: 2nd Regionals"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 16,
              right: 16,
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: MyApp.h6,
                color: Colors.black,
                fontWeight: FontWeight.w900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    child: WrappedText(
                      "Bilingual (English/Spanish)",
                    ),
                  ),
                  /*
                  InkWell(
                    onTap: () {
                      openWithHtml(
                        context,
                        "https://docs.google.com/document/d/1UBKxKsYBhC5d6IxjRxmYIItFoTFb9Fs_AgX5b64sjlA/edit?usp=sharing",
                        //don't close ourselves if at all possible
                        openHere: false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          WrappedText(
                            "View Paper Copy",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Icon(
                              Icons.link,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  */
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LanguageBody extends StatelessWidget {
  const LanguageBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.only(
        left: 16.0 + 16,
        right: 16,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: MyApp.h4,
          color: Colors.black,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("English"),
            Text(
              " && ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Spanish"),
          ],
        ),
      ),
      /*Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "English",
                style: TextStyle(
                  fontSize: MyApp.h4,
                ),
              ),
              CanRead(),
              CanWrite(),
              CanSpeak(),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Spanish",
                style: TextStyle(
                  fontSize: MyApp.h4,
                ),
              ),
              CanRead(),
              CanSpeak(),
              Text(
                ">",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MyApp.h3
                ),
              ),
              CanWrite(),
            ],
          )
        ],
      ),
      */
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    this.padded: true,
  }) : super(key: key);

  final String title;
  final bool padded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padded ? 16 : 0,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          bottom: 8.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: MyApp.h4,
            fontWeight: FontWeight.w900,
            letterSpacing: 8,
          ),
        ),
      ),
    );
  }
}
