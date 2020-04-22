import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/wrappedText.dart';

/*
Currently Using: C# (for game development), Java (for competitive programming)
 2-3 years Experience: C#, Java, HTML, CSS
 6 months Experience: Javascript (Vanilla), Python, C, Assembly
*/

/*
Languages: Fluent in English and Spanish; (read, write and speak)
*/

class ToolKitBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.robotoMono(
        color: MyApp.oldGrey,
        fontSize: MyApp.h4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 48.0,
            ),
            child: WrappedText(
              "last Updated: " + DateTime.now().toString() + ", ",
            ),
          ),
          Container(height: 4),
          CollapsibleSection(
            label: "education",
            sectionType: SectionType.Brackets,
            child: EducationSection(),
          ),
          Container(height: 4),
          Padding(
            padding: EdgeInsets.only(
              right: 48,
            ),
            child: Text(
              "//experience comes from coursework, projects, and work",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          Container(height: 4),
          CollapsibleSection(
            label: "experience To Tools",
            separator: "",
            sectionType: SectionType.Parenthesis,
            child: Container(
              margin: EdgeInsets.only(
                right: 48,
              ),
              height: 100,
              color: Colors.blue,
            ),
          ),
          Container(height: 4),
          CollapsibleSection(
            label: "suite To Certifications",
            separator: "",
            sectionType: SectionType.Parenthesis,
            child: Container(
              margin: EdgeInsets.only(
                right: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CollapsibleSection(
                    label: "\"Adobe CS6 Suite\"",
                    fontSize: MyApp.h5,
                    labelColor: Colors.white,
                    separator: " =>",
                    sectionType: SectionType.Brackets,
                    initiallyOpened: false,
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
                  CollapsibleSection(
                    label: "\"CIW Web Foundation Associate\"",
                    labelColor: Colors.white,
                    fontSize: MyApp.h5,
                    separator: " =>",
                    sectionType: SectionType.Brackets,
                    initiallyOpened: false,
                    child: Chips(
                      chips: [
                        "Network Technology Associate",
                        "Site Development",
                        "Internet Business",
                      ],
                    ),
                  ),
                  CollapsibleSection(
                    label: "\"IC​3​ GS4 Series\"",
                    labelColor: Colors.white,
                    fontSize: MyApp.h5,
                    separator: " =>",
                    sectionType: SectionType.Brackets,
                    initiallyOpened: false,
                    child: Chips(
                      chips: [
                        "Living Online",
                        "Key Applications",
                        "Computing Fundamentals",
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          CollapsibleSection(
            label: "spoken languages",
            sectionType: SectionType.Brackets,
            child: Padding(
              padding: EdgeInsets.only(
                right: 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "//fluent in both (Speak, Read, and Write)",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: MyApp.h5,
                    ),
                  ),
                  DefaultTextStyle(
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: MyApp.h5,
                    ),
                    child: Wrap(
                      children: <Widget>[
                        Text("English, "),
                        Text("Spanish,"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyApp.oldGrey,
            width: 2,
          ),
        ),
      ),
      child: CollapsibleSection(
        label: "University",
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
                      Text("Edinburg TX,"),
                    ],
                  ),
                  Text(
                    "Bachelor of Science in Computer Science,",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      Text("Graduated May 2019, "),
                      Text("with a 3.6 GPA,")
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
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: MyApp.oldGrey,
            width: 2,
          ),
        ),
      ),
      child: CollapsibleSection(
        label: "High School",
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
                    "Business Education Technology Academy (BETA), ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Edinburg, TX,"),
                ],
              ),
              Text(
                "High School Diploma,",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                children: <Widget>[
                  Text("Graduated May 2014, "),
                  Text("with a 3.9 GPA,")
                ],
              ),
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

class Chips extends StatelessWidget {
  Chips({
    @required this.chips,
  });

  final List<String> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        chips.length,
        (index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            child: Card(
              margin: EdgeInsets.only(
                right: 8,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: Text(
                  chips[index],
                  style: GoogleFonts.robotoMono(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
