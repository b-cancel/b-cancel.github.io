//section
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//plugins

//internal
import 'package:portfolio/bodies/toolkit/toolkit.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/projects/projects.dart';
import 'package:portfolio/bodies/work.dart';

//struct
class Region{
  IconData icon;
  String title;
  Widget body;
  bool initiallyOpened;
  GlobalKey headerKey;
  GlobalKey bodyKey;
  bool addLeftPadding;

  Region(
    this.icon,
    this.title,
    this.body,
    this.headerKey,
    this.bodyKey,
    {
      this.initiallyOpened: false,
      this.addLeftPadding: true,
    }
  );
}

final ValueNotifier<bool> aSectionToggled = new ValueNotifier<bool>(false);

tellSystem(){
  aSectionToggled.value = true;
}

List<Region> regions = [
  Region(
    FontAwesomeIcons.userAlt,
    "About Me",
    Container(), //needs scroll controller so we set it elsewhere
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true, 
  ),
  Region(
    FontAwesomeIcons.tools,
    "Toolkit",
    ToolKitBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true,
  ),
  Region(
    FontAwesomeIcons.suitcase, 
    "Experience", 
    WorkExperienceBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true,
  ),
  Region(
    FontAwesomeIcons.flask,
    "Projects",
    ProjectsBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true,
    addLeftPadding: false,
  ),
  Region(
    Icons.thumb_up,
    "References",
    ReferencesBody(), 
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true, //TODO: remove after debug
  ),
  Region(
    FontAwesomeIcons.solidCommentAlt,
    "Contact Me",
    ContactMeBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true,
  ),
];