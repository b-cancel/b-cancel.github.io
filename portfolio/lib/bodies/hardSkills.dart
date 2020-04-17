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
