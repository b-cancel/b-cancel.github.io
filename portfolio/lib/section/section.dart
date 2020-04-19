//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';

//internal
import 'package:portfolio/section/sectionBody.dart';
import 'package:portfolio/section/sectionHeader.dart';

enum SectionType {Collection, Class, Function}
Map<SectionType, String> sectionTypeToLeft = {
  SectionType.Collection : "[",
  SectionType.Class : "{",
  SectionType.Function : "(", 
};
Map<SectionType, String> sectionTypeToRight = {
  SectionType.Collection : "]",
  SectionType.Class : "}",
  SectionType.Function : ")", 
};
Map<SectionType, Color> sectionTypeToColor = {
  SectionType.Collection : MyApp.highlightPink,
  SectionType.Class : MyApp.highlightGreen,
  SectionType.Function : MyApp.blueText, 
};

//widget
class RegularSection extends StatefulWidget {
  RegularSection({
    @required this.sectionType,
    @required this.label,
    @required this.title,
    @required this.body,
    this.initiallyOpened: true,
    this.leftSpacing: true,

  });

  final SectionType sectionType;
  final String label;
  final String title;
  final Widget body;
  final bool initiallyOpened;
  final bool leftSpacing;

  @override
  _RegularSectionState createState() => _RegularSectionState();
}

class _RegularSectionState extends State<RegularSection> {
  ValueNotifier<bool> sectionOpened;

  @override
  void initState() {
    //super init
    super.initState();
    //initialization
    sectionOpened = new ValueNotifier<bool>(widget.initiallyOpened);
    //notifier
    sectionOpened.addListener(tellSystem);
  }

  @override
  void dispose() { 
    sectionOpened.removeListener(tellSystem);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeader(
          sectionType: widget.sectionType,
          sectionOpened: sectionOpened,
          label: widget.label,
          title: widget.title,
        ),
        SectionBody(
          sectionType: widget.sectionType,
          sectionOpened: sectionOpened,
          child: widget.body,
          leftSpacing: widget.leftSpacing,
        ),
      ],
    );
  }
}
