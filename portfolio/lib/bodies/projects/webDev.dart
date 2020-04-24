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
                  github: "https://github.com/b-cancel/b-cancel.github.io",
                  livePage: "https://b-cancel.github.io/",
                ),
                ProjectSection(
                  label: "Attend",
                  github: "https://github.com/b-cancel/Attend_Public",
                ),
                ProjectSection(
                  label: "Ambit Energy",
                  github: "https://github.com/b-cancel/Ambit_Energy_Consultant_Website",
                  livePage: "https://b-cancel.github.io/Ambit_Energy_Consultant_Website",
                ),
              ],
            ),
          ),
          SubSection(
            label: "Assignments/Competitions",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Shazam Clone",
                  github: "https://github.com/b-cancel/Ruby_Shazam_Clone",
                ),
                ProjectSection(
                  label: "Rental Property Searcher",
                  github: "https://github.com/b-cancel/Rental_Property_Searcher",
                ),
                ProjectSection(
                  label: "TSA Web",
                  github: "https://github.com/b-cancel/Technology_Student_Association_Website",
                  livePage: "https://b-cancel.github.io/Technology_Student_Association_Website/index.html",
                ),
                ProjectSection(
                  label: "HS Web Dev Final",
                  github: "https://github.com/b-cancel/Web_Development_Final",
                  livePage: "https://b-cancel.github.io/Web_Development_Final",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}