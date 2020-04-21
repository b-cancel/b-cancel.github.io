import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/wrappedText.dart';

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
          WrappedText(
            "last Updated: " + DateTime.now().toString(),
          ),
          Container(height: 4),
          UnCollapsibleSection(
            label: "education", 
            sectionType: SectionType.CurlyBraces, 
            child: Container(
              height: 100,
              color: Colors.red,
            ),
          ),
          Container(height: 4),
          Text(
            "//experience comes from coursework, projects, and work",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          Container(height: 4),
          UnCollapsibleSection(
            label: "experience To Tools", 
            separator: "",
            sectionType: SectionType.Parenthesis, 
            child: Container(
              height: 100,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regularRegion.dart';

class HardSkillsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RegularRegion(
        title: "Formal Education",
        titleColor: MyApp.yellowText,
        body: Column(
          children: <Widget>[
            Text("college stuff"),
            RegularRegion(
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
      RegularRegion(
        title: "Languages/Frameworks beep boop bap",
        titleColor: MyApp.greenText,
        body: Column(
          children: <Widget>[
            Text("all languages with paired framework with profficiency"),
          ],
        ),
      ),
      RegularRegion(
        title: "Tools",
        titleColor: MyApp.yellowText,
        body: Column(
          children: <Widget>[
            Text("IDEs, version control"),
          ],
        ),
      ),
      RegularRegion(
        title: "Certifications",
        titleColor: MyApp.blueText,
        body: Column(
          children: <Widget>[
            Text("adobe stuff"),
          ],
        ),
      ),
    ]);
  }
}

*/