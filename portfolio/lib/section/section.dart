//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';

//internal
import 'package:portfolio/section/sectionBody.dart';
import 'package:portfolio/section/sectionHeader.dart';

enum SectionType {CurlyBraces, Brackets, Parenthesis}
Map<SectionType, String> sectionTypeToLeft = {
  SectionType.CurlyBraces : "[",
  SectionType.Brackets : "{",
  SectionType.Parenthesis : "(", 
};
Map<SectionType, String> sectionTypeToRight = {
  SectionType.CurlyBraces : "]",
  SectionType.Brackets : "}",
  SectionType.Parenthesis : ")", 
};
Map<SectionType, Color> sectionTypeToColor = {
  SectionType.CurlyBraces : MyApp.highlightPink,
  SectionType.Brackets : MyApp.highlightGreen,
  SectionType.Parenthesis : MyApp.blueText, 
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
    this.collapsible: true,
  });

  final SectionType sectionType;
  final String label;
  final String title;
  final Widget body;
  final bool initiallyOpened;
  final bool leftSpacing;
  final bool collapsible;

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
          collapsible: widget.collapsible,
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
