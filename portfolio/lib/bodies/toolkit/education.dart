//flutter
import 'package:flutter/material.dart';

//plugins
import 'package:google_fonts/google_fonts.dart';

//internal
import 'package:portfolio/bodies/toolkit/toolkit.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/main.dart';

//widgets
class EducationSection extends StatelessWidget {
  const EducationSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget items = Wrap(
      children: <Widget>[
        University(),
        HighSchool(),
      ],
    );

    //build
    return Stack(
      children: <Widget>[
        items,
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(
              right: 24.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: MyApp.bodyColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class University extends StatelessWidget {
  const University({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 24,
      ),
      margin: EdgeInsets.only(
        right: 24,
      ),
      child: CollapsibleSection(
        label: "UTRGV",
        separator: "",
        sectionType: SectionType.Parenthesis,
        child: DefaultTextStyle(
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: MyApp.h5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: <Widget>[
                      Text(
                        "The University of Texas at Rio Grande Valley, ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Loc: ",
                        style: GoogleFonts.robotoMono(
                          color: MyApp.oldGrey,
                        ),
                      ),
                      Text("Edinburg TX,"),
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Text(
                        "Deg: ",
                        style: GoogleFonts.robotoMono(
                          color: MyApp.oldGrey,
                        ),
                      ),
                      Text(
                        "Bachelor of Science in Computer Science,",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Text(
                        "Graduated: ",
                        style: GoogleFonts.robotoMono(
                          color: MyApp.oldGrey,
                        ),
                      ),
                      Text("May 2019, "),
                      Text(
                        "GPA: ",
                        style: GoogleFonts.robotoMono(
                          color: MyApp.oldGrey,
                        ),
                      ),
                      Text("3.6,")
                    ],
                  ),
                ],
              ),
              CoursesSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class CoursesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> courseWork = [
      "Discrete Data Structures",
      "Algorithms & Data Structures",
      "Design & Analysis of Algorithms",
      "Automata, Formal Languages & Computation",
      "Software Engineering 1 & 2",
      "Internet Programming",
      "Introduction to Game Development",
      "Database Design & Implementation",
      "Systems Programming",
      "Computer Architecture",
      "Object Oriented Programing in C#",
      "Computer Organization & Assembly Languages",
    ];

    //build
    return CollapsibleSection(
      sectionType: SectionType.Brackets,
      label: "Coursework",
      labelColor: Colors.white,
      fontSize: MyApp.h5,
      separator: ":",
      initiallyOpened: false,
      child: Chips(
        chips: courseWork,
      ),
    );
  }
}

class HighSchool extends StatelessWidget {
  const HighSchool({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 24,
      ),
      margin: EdgeInsets.only(
        right: 24,
      ),
      child: CollapsibleSection(
        label: "BETA",
        separator: "",
        initiallyOpened: false,
        sectionType: SectionType.Parenthesis,
        child: DefaultTextStyle(
          style: GoogleFonts.robotoMono(
            color: Colors.white,
            fontSize: MyApp.h5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: <Widget>[
                  Text(
                    "Business Education Technology Academy, ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Loc: ",
                    style: GoogleFonts.robotoMono(
                      color: MyApp.oldGrey,
                    ),
                  ),
                  Text("Edinburg TX,"),
                ],
              ),
              Wrap(
                children: <Widget>[
                  Text(
                    "Deg: ",
                    style: GoogleFonts.robotoMono(
                      color: MyApp.oldGrey,
                    ),
                  ),
                  Text(
                    "High School Diploma,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Wrap(
                children: <Widget>[
                  Text(
                    "Graduated: ",
                    style: GoogleFonts.robotoMono(
                      color: MyApp.oldGrey,
                    ),
                  ),
                  Text("May 2014, "),
                  Text(
                    "GPA: ",
                    style: GoogleFonts.robotoMono(
                      color: MyApp.oldGrey,
                    ),
                  ),
                  Text("3.9,")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
