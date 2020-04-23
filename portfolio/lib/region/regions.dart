//section
import 'package:flutter/material.dart';

//plugins
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/bodies/toolkit/toolkit.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/projects.dart';
import 'package:portfolio/bodies/work.dart';

//struct
class Region{
  IconData icon;
  String title;
  Widget body;
  bool initiallyOpened;
  GlobalKey headerKey;
  GlobalKey bodyKey;

  Region(
    this.icon,
    this.title,
    this.body,
    this.headerKey,
    this.bodyKey,
    {
      this.initiallyOpened: false,
    }
  );
}

final ValueNotifier<bool> aSectionToggled = new ValueNotifier<bool>(false);

tellSystem(){
  aSectionToggled.value = true;
}

List<Region> regions = [
  Region(
    FontAwesome.user_circle,
    "About Me",
    Container(), //needs scroll controller so we set it elsewhere
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true, 
  ),
  Region(
    FontAwesome5Solid.tools,
    "Toolkit",
    ToolKitBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true, //TODO: remove after testin
  ),
  Region(
    FontAwesome.suitcase, 
    "Experience", 
    WorkExperienceBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true, //TODO: remove after testin
  ),
  Region(
    FontAwesome.flask,
    "Projects",
    ProjectsBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true,
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
    FontAwesome5Solid.comment_alt,
    "Contact Me",
    ContactMeBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true,
  ),
];