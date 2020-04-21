//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';

//internal
import 'package:portfolio/region/regionBody.dart';
import 'package:portfolio/region/regionHeader.dart';
import 'package:portfolio/region/regions.dart';

//widget
class RegularRegion extends StatefulWidget {
  RegularRegion({
    @required this.title,
    @required this.titleColor,
    @required this.body,
    this.initiallyOpened: false,
    this.leftSpacing: true,
    this.fontSize: MyApp.h1,
  });

  final String title;
  final Color titleColor;
  final Widget body;
  final bool initiallyOpened;
  final bool leftSpacing;
  final double fontSize;

  @override
  _RegularRegionState createState() => _RegularRegionState();
}

class _RegularRegionState extends State<RegularRegion> {
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
        RegionHeader(
          regionOpened: sectionOpened,
          title: widget.title,
          titleColor: widget.titleColor,
          fontSize: widget.fontSize,
        ),
        RegionBody(
          regionOpened: sectionOpened,
          child: widget.body,
          leftSpacing: widget.leftSpacing,
        ),
      ],
    );
  }
}
