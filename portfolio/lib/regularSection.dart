//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

//internal
import 'package:portfolio/sectionBody.dart';
import 'package:portfolio/sectionHeader.dart';

//internal
import 'main.dart';

//widget
class RegularSection extends StatefulWidget {
  RegularSection({
    @required this.title,
    @required this.titleColor,
    this.icon,
    @required this.body,
    this.initiallyOpened: false,
  });

  final String title;
  final Color titleColor;
  final Icon icon;
  final Widget body;
  final bool initiallyOpened;

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
          title: widget.title,
          titleColor: widget.titleColor
        ),
        SectionBody(
          sectionOpened: sectionOpened,
          child: widget.body,
        ),
      ],
    );
  }
}
