import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data/basic.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu/expandingText.dart';
import 'package:portfolio/menu/myWorkTitle.dart';
import 'package:portfolio/menu/sections/software.dart';
import 'package:portfolio/menu/swapingText.dart';
import 'package:portfolio/qrCode.dart';
import 'package:portfolio/utils/chips.dart';
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/link/nonWebLink.dart';
import 'package:portfolio/utils/link/openLink.dart';
import 'package:portfolio/utils/link/ui/hover.dart';
import 'package:portfolio/utils/mySnackBar.dart';
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

  Widget copyLink({
    IconData icon,
    String thingToCopy,
  }) {
    return MyIconLink(
      action: () {
        copyToClipboard(
          context,
          thingToCopy,
        );
      },
      icon: icon,
    );
  }

  Widget webLink({
    String title,
    IconData icon,
    String generalUrl,
    String specificUrl,
  }) {
    return MyIconLink(
      action: () {
        openWithHtml(
          context,
          generalUrl + specificUrl,
          openHere: false,
        );
      },
      icon: icon,
    );
  }

  Widget saveContactLink() {
    return MyIconLink(
      action: () async {
        downloadQrCode(context);
      },
      icon: PortfolioIcons.address_card,
    );
  }

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

    return Stack(
      children: [
        Container(
          color: Colors.white,
          //NOTE: avoiding fancy scroll physics for compatibilty sake
          child: SingleChildScrollView(
            controller: scrollController,
            //atleast spacing to match name
            padding: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 0,
            ),
            //children
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 16.0 + 24,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Wrap(
                        children: [
                          //on click -> open in new tab
                          //copy is easy from here
                          //open in this tab not allowed
                          webLink(
                            title: "Github",
                            icon: PortfolioIcons.github,
                            generalUrl: generalGithub,
                            specificUrl: myGithub,
                          ),
                          webLink(
                            title: "Linked In",
                            icon: PortfolioIcons.linkedin,
                            generalUrl: generalLinkedIn,
                            specificUrl: myLinkedIn,
                          ),
                          webLink(
                            title: "Hacker Rank",
                            icon: PortfolioIcons.hackerrank,
                            generalUrl: generalHackerRank,
                            specificUrl: myHackerRank,
                          ),
                          copyLink(
                            icon: PortfolioIcons.phone,
                            thingToCopy: myNumber,
                          ),
                          copyLink(
                            icon: PortfolioIcons.email,
                            thingToCopy: myEmail,
                          ),
                          saveContactLink(),
                          MyIconLink(
                            action: () {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: kTabScrollDuration,
                                curve: Curves.easeOut,
                              );
                            },
                            icon: Icons.qr_code,
                          ),
                        ],
                      ),
                    ),
                    //NOTE: we start spreaded when the secation starts open
                    ExpandingSection(
                      title: "Experience",
                      useSpreadingTitle: true,
                      startOpen: true,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SwappingSection(
                            title: "Mobile Development and Design",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("05/2020 -> 07/2020"),
                                Text("Mobile Development and Design",
                                    style: bold),
                                Text("Lawn Buddy"),
                                Text("Remote"),
                              ],
                            ),
                          ),
                          SwappingSection(
                            title: "Web Development",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("03/2020 -> 09/2020"),
                                Text("Web Development", style: bold),
                                Text("Lebron Group Land Surveying"),
                                Text("Remote"),
                              ],
                            ),
                          ),
                          SwappingSection(
                            title: "Barista",
                            startOpen: false,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("10/2019 -> 05/2020"),
                                Text("Barista", style: bold),
                                Text("Starbucks"),
                                Text("Edinburg, TX"),
                              ],
                            ),
                          ),
                          SwappingSection(
                            title: "App Development",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("05/2018 -> 08/2018"),
                                Text("App Development", style: bold),
                                Text("CleverSolve"),
                                Text("Edinburg, TX"),
                                Text("Summer Internship"),
                              ],
                            ),
                          ),
                          SwappingSection(
                            title: "Web Development and Design",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("07/2017 -> 09/2017"),
                                Text("Web Development and Design", style: bold),
                                Text(
                                  "Lebron Group Land Surveying",
                                ),
                                Text("Winter Park, FL"),
                              ],
                            ),
                          ),
                          SwappingSection(
                            title: "Graphic Design and Video Editing",
                            startOpen: false,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("09/2014 -> 05/2015"),
                                Text("Graphic Design and Video Editing",
                                    style: bold),
                                Text(
                                  "UT Center for Railway Safety",
                                ),
                                Text("Edinburg, TX"),
                              ],
                            ),
                          ),
                          SwappingSection(
                            title: "Graphic Design and Video Editing",
                            startOpen: false,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("09/2013 -> 05/2014"),
                                Text("Graphic Design and Video Editing",
                                    style: bold),
                                Text(
                                  "IT Marketing Division at UTPA",
                                ),
                                Text("Edinburg, TX"),
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
                                Text("05/2013 -> 05/2014"),
                                Text("Robotics Coach", style: bold),
                                Text(
                                  "Business Education Technology Academy",
                                ),
                                Text(
                                  "Edinburg, TX",
                                ),
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
                            title: "BS in Computer Science, 3.6",
                            startOpen: false,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "BS in Computer Science",
                                  style: bold,
                                ),
                                Text("University of Rio Grande Valley"),
                                Text("May 2019: Cum Laude"),
                                Text("3.6 GPA"),
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
                          SwappingSection(
                            title: "High School Diploma, 3.9",
                            startOpen: false,
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "High School Distinguished Diploma",
                                  style: bold,
                                ),
                                Text(
                                  "Business Education Technololgy Academy",
                                ),
                                Text(
                                  "May 2014: Magna Cum Laude",
                                ),
                                Text("3.9 GPA"),
                              ],
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
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  color: Colors.black,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                          ),
                          ExpandingSection(
                            title: "Awards",
                            startOpen: true,
                            content: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                              ),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                  color: Colors.black,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "2012 – 2013",
                                            style: bold,
                                          ),
                                          WrappedText(
                                              "- TSA Member of the Year"),
                                          WrappedText(
                                              "- Technology Problem Solving: 2nd Regionals"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                            WrappedText(
                              "Bilingual (English/Spanish)",
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
                    ),
                    QRWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: UnderConstructionChip(),
        ),
      ],
    );
  }
}

class MyIconLink extends StatelessWidget {
  const MyIconLink({
    Key key,
    @required this.action,
    @required this.icon,
  }) : super(key: key);

  final Function action;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return OpaqueOnHover(
      invert: true,
      child: Material(
        borderRadius: BorderRadius.circular(56),
        color: Colors.transparent,
        child: InkWell(
          //tapping on mobile
          //clicking on web
          //both expect a quickAction
          onTap: () {
            action();
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 4,
            ),
            height: 30,
            width: 30,
            child: Icon(
              icon,
            ),
          ),
        ),
      ),
    );
  }
}

class UnderConstructionChip extends StatelessWidget {
  const UnderConstructionChip({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          "Under Construction",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class QRWidget extends StatelessWidget {
  const QRWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpaqueOnHover(
      invert: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            downloadQrCode(context);
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 250,
                maxWidth: 250,
              ),
              child: Container(
                width: 250,
                height: 250,
                child: AdjustableQrCode(
                  squaresColor: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

downloadQrCode(BuildContext context) async {
  //NOTE: this only works in the web but that's where I need it to work
  String fileName = "Bryan_Cancel.vcf";
  String url = "vcards/" + fileName;
  //TODO: remember to switch this to false when ready to build
  bool testing = false;
  if (testing == false) {
    //true if NOT TESTING
    url = ("assets/" + url);
  }
  if (await downloadFile(url)) {
    showSnackBar(
      context,
      backgroundColor: Colors.green,
      textColor: Colors.black,
      icon: PortfolioIcons.check,
      prefix: "Contact Card ",
      message: "Downloaded",
    );
  } else {
    showSnackBar(context,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        icon: PortfolioIcons.warning,
        prefix: 'Contact Card Download ',
        message: 'Not Supported',
        suffix: ', Trying Scanning The QR Code Instead');
  }
}
