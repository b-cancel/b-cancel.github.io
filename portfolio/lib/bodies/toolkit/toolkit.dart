//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:google_fonts/google_fonts.dart';

//internal
import 'package:portfolio/bodies/toolkit/education.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/bodies/toolkit/tools.dart';
import 'package:portfolio/utils/wrappedText.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/main.dart';

//widget
class ToolKitBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.robotoMono(
        color: MyApp.oldGrey,
        fontSize: MyApp.h4,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: 48.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            WrappedText(
              "last Updated: " + DateTime.now().toString() + ", ",
            ),
            Container(height: 4),
            CollapsibleSection(
              label: "education",
              sectionType: SectionType.Brackets,
              child: EducationSection(),
            ),
            Container(height: 4),
            Text(
              "//experience comes from coursework, projects, and work",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            Container(height: 4),
            CollapsibleSection(
              label: "experience To Tools",
              separator: "",
              sectionType: SectionType.CurlyBraces,
              child: ToolsSection(),
            ),
            Container(height: 4),
            CollapsibleSection(
              label: "suite To Certifications",
              separator: "",
              sectionType: SectionType.CurlyBraces,
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
            CollapsibleSection(
              label: "Awards",
              sectionType: SectionType.Brackets,
              initiallyOpened: false,
              child: Chips(
                chips: [
                  "2014 High School Legendary Student Award",
                  "2014 TSA Vex Robotics (7th State)",
                  "2014 TSA Web Design (4th Nationals)",
                  "2013 Member Of The Year",
                  "2013 Technology Problem Solving (2nd Regionals)",
                ],
              ),
            ),
            CollapsibleSection(
              label: "human Languages",
              sectionType: SectionType.Brackets,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                    style: GoogleFonts.robotoMono(
                      color: Colors.white,
                      fontSize: MyApp.h5,
                    ),
                    child: DefaultTextStyle(
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                      ),
                      child: Wrap(
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[
                              Text("English"),
                              Text(
                                " (speak, read, write,), ",
                                style: GoogleFonts.robotoMono(
                                  color: MyApp.oldGrey,
                                ),
                              ),
                            ],
                          ),
                          Wrap(
                            children: <Widget>[
                              Text("Spanish"),
                              Text(
                                " (speak, read, write,),",
                                style: GoogleFonts.robotoMono(
                                  color: MyApp.oldGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          return AChip(
            child: Text(
              chips[index],
              style: GoogleFonts.robotoMono(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AChip extends StatelessWidget {
  const AChip({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
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
          child: child,
        ),
      ),
    );
  }
}