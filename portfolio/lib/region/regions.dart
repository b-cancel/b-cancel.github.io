//section
import 'package:flutter/material.dart';

//plugins

//internal
import 'package:portfolio/bodies/toolkit/toolkit.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/projects/projects.dart';
import 'package:portfolio/bodies/work.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';

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
    PortfolioIcons.user,
    "About Me",
    Container(), //needs scroll controller so we set it elsewhere
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true, 
  ),
  Region(
    PortfolioIcons.tools,
    "Toolkit",
    ToolKitBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true,
  ),
  Region(
    PortfolioIcons.suitcase, 
    "Experience", 
    WorkExperienceBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true,
  ),
  Region(
    PortfolioIcons.flask,
    "Projects",
    ProjectsBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true,
    addLeftPadding: false,
  ),
  Region(
    PortfolioIcons.thumbs_up,
    "References",
    ReferencesBody(), 
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    //initiallyOpened: true, //TODO: remove after debug
  ),
  Region(
    PortfolioIcons.comment_alt,
    "Contact Me",
    ContactMeBody(),
    //these are updated by their respective layout builders
    GlobalKey(),
    GlobalKey(),
    initiallyOpened: true,
  ),
];