//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/section/sectionBody.dart';
import 'package:portfolio/section/sectionHeader.dart';

//collection -> highlight pink & "[]"
//class -> highlight green & "{}"
//instance -> ??? blue "()"

//widget
class RegularSection extends StatefulWidget {
  RegularSection({
    @required this.title,
    @required this.label,
    @required this.titleColor,
    this.icon,
    @required this.body,
    this.initiallyOpened: false,
    this.leftSpacing: true,
  });

  final String title;
  final String label;
  final Color titleColor;
  final Icon icon;
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

    sectionOpened = new ValueNotifier<bool>(widget.initiallyOpened);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeader(
          sectionOpened: sectionOpened,
          label: widget.label,
          title: widget.title,
          titleColor: widget.titleColor
        ),
        SectionBody(
          sectionOpened: sectionOpened,
          child: widget.body,
          leftSpacing: widget.leftSpacing,
        ),
      ],
    );
  }
}
