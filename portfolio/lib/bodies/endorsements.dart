import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';

class EndorsementsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RegularSection(
          title: "References",
          label: "Set",
          titleColor: MyApp.highlightPink,
          body: Container(
            color: Colors.red,
            height: 250,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        RegularSection(
          title: "Recommendations",
          label: "Set",
          initiallyOpened: true,
          titleColor: MyApp.highlightPink,
          body: Container(
            color: Colors.red,
            height: 250,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}