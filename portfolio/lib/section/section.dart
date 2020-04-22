//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';

//internal
import 'package:portfolio/section/sectionBody.dart';
import 'package:portfolio/section/sectionHeader.dart';

enum SectionType {Brackets, CurlyBraces, Parenthesis}
Map<SectionType, String> sectionTypeToLeft = {
  SectionType.Brackets : "[",
  SectionType.CurlyBraces : "{",
  SectionType.Parenthesis : "(", 
};
Map<SectionType, String> sectionTypeToRight = {
  SectionType.Brackets : "]",
  SectionType.CurlyBraces : "}",
  SectionType.Parenthesis : ")", 
};
Map<SectionType, Color> sectionTypeToColor = {
  SectionType.Brackets : MyApp.highlightPink,
  SectionType.CurlyBraces : MyApp.highlightGreen,
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
  final ValueNotifier<bool> sectionOpened = new ValueNotifier<bool>(true);

  @override
  void initState() {
    //super init
    super.initState();
    //initialization
    sectionOpened.value = widget.initiallyOpened;
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
