//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

//widget
class AppDevelopment extends StatelessWidget {
  const AppDevelopment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevelopmentSection(
      label: "App Development",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubSection(
            label: "Released",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Swol",
                  child: null,
                ),
              ],
            ),
          ),
          SubSection(
            label: "Prototypes",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Half Life",
                  child: null,
                ),
                ProjectSection(
                  label: "Leashed",
                  child: null,
                ),
              ],
            ),
          ),
          SubSection(
            label: "Toolkits",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Contact Picker",
                  child: null,
                ),
                ProjectSection(
                  label: "Fluttergram",
                  child: null,
                ),
                ProjectSection(
                  label: "Timer & Stopwatch",
                  child: null,
                ),
                ProjectSection(
                  label: "Material Sheets",
                  child: null,
                ),
              ],
            ),
          ),
          SubSection(
            label: "Quick Builds",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Tip Calculator",
                  child: null,
                ),
                ProjectSection(
                  label: "Score Keeper",
                  child: null,
                ),
                ProjectSection(
                  label: "Aero Press Timer",
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