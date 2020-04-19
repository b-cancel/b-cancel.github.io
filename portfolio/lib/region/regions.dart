//section
import 'package:flutter/material.dart';

//plugins
import 'package:flutter_icons/flutter_icons.dart';

//internal
import 'package:portfolio/bodies/aboutMe.dart';
import 'package:portfolio/bodies/contactMe.dart';
import 'package:portfolio/bodies/endorsements.dart';
import 'package:portfolio/bodies/projects.dart';
import 'package:portfolio/bodies/softSkills.dart';
import 'package:portfolio/bodies/work.dart';

//struct
class Region{
  IconData icon;
  String title;
  Widget body;
  bool initiallyOpened;
  ValueKey headerKey;
  ValueKey bodyKey;

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

List<Region> regions = [
  Region(
    FontAwesome.user_circle,
    "About Me",
    Padding(
      padding: EdgeInsets.only(
        right: 16,
      ),
      child: AboutMeBody(),
    ),
    //these are updated by their respective layout builders
    ValueKey("h0"),
    ValueKey("b0"),
    initiallyOpened: true,
  ),
  Region(
    FontAwesome5Solid.tools,
    "Skills",
    SoftSkillsBody(),
    //these are updated by their respective layout builders
    ValueKey("h1"),
    ValueKey("b1"),
  ),
  Region(
    FontAwesome.suitcase, 
    "Experience", 
    WorkExperienceBody(),
    //these are updated by their respective layout builders
    ValueKey("h2"),
    ValueKey("b2"),
  ),
  Region(
    FontAwesome.flask,
    "Projects",
    ProjectsBody(),
    //these are updated by their respective layout builders
    ValueKey("h3"),
    ValueKey("b3"),
  ),
  Region(
    Icons.thumb_up,
    "References",
    ReferencesBody(),
    //these are updated by their respective layout builders
    ValueKey("h4"),
    ValueKey("b4"),
    initiallyOpened: true, //TODO: remove after testin
  ),
  Region(
    FontAwesome5.comment_alt,
    "Contact Me",
    ContactMeBody(),
    //these are updated by their respective layout builders
    ValueKey("h5"),
    ValueKey("b5"),
    initiallyOpened: true,
  ),
];