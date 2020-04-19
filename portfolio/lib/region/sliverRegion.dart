//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

//internal
import 'package:portfolio/region/regionBody.dart';
import 'package:portfolio/region/regionHeader.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';

//widget
class SliverRegion extends StatefulWidget {
  SliverRegion({
    @required this.headerKey,
    @required this.bodyKey,
    @required this.title,
    @required this.body,
    this.initiallyOpened: false,
    this.leftSpacing: true,
  });

  final ValueKey headerKey;
  final ValueKey bodyKey;
  final String title;
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
    return SliverStickyHeader(
      header: Container(
        key: widget.headerKey,
        child: RegionHeader(
          regionOpened: sectionOpened, 
          title: widget.title,
          titleColor: MyApp.oldPurple,
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              key: widget.bodyKey,
              child: RegionBody(
                regionOpened: sectionOpened, 
                child: widget.body,
                leftSpacing: widget.leftSpacing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}