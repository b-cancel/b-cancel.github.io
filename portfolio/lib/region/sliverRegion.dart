//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

//internal
import 'package:portfolio/region/regionBody.dart';
import 'package:portfolio/region/regionHeader.dart';

//internal
import 'package:portfolio/main.dart';

//widget
class SliverRegion extends StatefulWidget {
  SliverRegion({
    @required this.title,
    this.icon,
    @required this.body,
    this.initiallyOpened: false,
    this.leftSpacing: true,
  });

  final String title;
  final Icon icon;
  final Widget body;
  final bool initiallyOpened;
  final bool leftSpacing;

  @override
  _SliverRegionState createState() => _SliverRegionState();
}

class _SliverRegionState extends State<SliverRegion> {
  ValueNotifier<bool> sectionOpened;

  @override
  void initState() {
    //super init
    super.initState();

    sectionOpened = new ValueNotifier<bool>(widget.initiallyOpened);
  }

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: RegionHeader(
        regionOpened: sectionOpened, 
        title: widget.title,
        titleColor: MyApp.oldPurple,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            RegionBody(
              regionOpened: sectionOpened, 
              child: widget.body,
              leftSpacing: widget.leftSpacing,
            ),
          ],
        ),
      ),
    );
  }
}