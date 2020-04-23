//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

//widget
class WebDevelopment extends StatelessWidget {
  const WebDevelopment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevelopmentSection(
      label: "Web Development",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SubSection(
            label: "Completed", 
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Portfolio Website",
                ),
                ProjectSection(
                  label: "Attend",
                ),
                ProjectSection(
                  label: "Ambit Energy",
                ),
              ],
            ),
          ),
          SubSection(
            label: "Class Assignments",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Shazam Clone",
                  child: null,
                ),
                ProjectSection(
                  label: "Rental Property Searcher",
                  child: null,
                ),
                ProjectSection(
                  label: "HS Web Dev Final",
                  child: null,
                ),
              ],
            ),
          ),
          SubSection(
            label: "Competition",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "TSA Web",
                  child: null,
                ),
                ProjectSection(
                  label: "Shazam Clone",
                  child: null,
                ),
                ProjectSection(
                  label: "Rental Property Searcher",
                  child: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}