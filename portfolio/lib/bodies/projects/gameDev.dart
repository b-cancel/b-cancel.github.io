//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

//widget
class GameDevelopment extends StatelessWidget {
  const GameDevelopment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevelopmentSection(
      label: "Game Development",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SubSection(
            label: "Prototypes",
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                ProjectSection(
                  label: "Squishables",
                  child: null,
                ),
                ProjectSection(
                  label: "Itzo",
                  child: null,
                ),
                ProjectSection(
                  label: "Super Retriever",
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
                  label: "Color Mixing",
                  child: null,
                ),
                ProjectSection(
                  label: "2D Outlines",
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