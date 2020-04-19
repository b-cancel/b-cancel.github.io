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

  Region(
    this.icon,
    this.title,
    this.body,
    {this.initiallyOpened: false}
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
    //initiallyOpened: true,
  ),
  Region(
    FontAwesome5Solid.tools,
    "Skills",
    SoftSkillsBody(),
  ),
  Region(
    FontAwesome.suitcase, 
    "Experience", 
    WorkExperienceBody(),
  ),
  Region(
    FontAwesome.flask,
    "Projects",
    ProjectsBody(),
  ),
  Region(
    Icons.thumb_up,
    "References",
    ReferencesBody(),
    //initiallyOpened: true, //TODO: remove after testin
  ),
  Region(
    FontAwesome5.comment_alt,
    "Contact Me",
    ContactMeBody(),
    //initiallyOpened: true,
  ),
];