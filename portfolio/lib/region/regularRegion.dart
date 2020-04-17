//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/region/regionBody.dart';
import 'package:portfolio/region/regionHeader.dart';

//widget
class RegularRegion extends StatefulWidget {
  RegularRegion({
    @required this.title,
    @required this.titleColor,
    @required this.body,
    this.initiallyOpened: false,
    this.leftSpacing: true,
  });

  final String title;
  final Color titleColor;
  final Widget body;
  final bool initiallyOpened;
  final bool leftSpacing;

  @override
  _RegularRegionState createState() => _RegularRegionState();
}

class _RegularRegionState extends State<RegularRegion> {
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
        RegionHeader(
          regionOpened: sectionOpened,
          title: widget.title,
          titleColor: widget.titleColor
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
