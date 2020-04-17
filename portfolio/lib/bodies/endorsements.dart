import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';

class EndorsementsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RegularSection(
          sectionType: SectionType.Collection,
          title: "References",
          label: "List",
          body: Container(
            color: Colors.red,
            height: 250,
            width: 500,
          ),
        ),
        RegularSection(
          sectionType: SectionType.Collection,
          title: "Recommendations",
          label: "List",
          initiallyOpened: true,
          body: Container(
            color: Colors.red,
            height: 250,
            width: 500,
          ),
        ),
      ],
    );
  }
}