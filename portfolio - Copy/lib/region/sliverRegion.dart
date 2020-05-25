//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:sticky_headers/sticky_headers.dart';

//internal
import 'package:portfolio/region/regionBody.dart';
import 'package:portfolio/region/regionHeader.dart';

//internal
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';
import 'package:portfolio/utils/keepAliveMixin.dart';

//widget
class SliverRegion extends StatefulWidget {
  SliverRegion({
    @required this.headerKey,
    @required this.bodyKey,
    @required this.title,
    @required this.body,
    this.initiallyOpened: false,
    this.leftSpacing: true,
    this.useStickyHeaders: false,
    this.returnAsSliver: false,
  });

  final GlobalKey headerKey;
  final GlobalKey bodyKey;
  final String title;
  final Widget body;
  final bool initiallyOpened;
  final bool leftSpacing;
  final bool useStickyHeaders;
  final bool returnAsSliver;

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
    Widget header = RegionHeader(
      regionOpened: sectionOpened,
      title: widget.title,
      titleColor: MyApp.oldPurple,
    );

    Widget body = RegionBody(
      regionOpened: sectionOpened,
      child: widget.body,
      leftSpacing: widget.leftSpacing,
    );

    if (widget.returnAsSliver) {
      if (widget.useStickyHeaders) {
        return SliverStickyHeader(
          header: Container(
            key: widget.headerKey,
            child: header,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                //KeepAliveMixin here is a severe performance hit
                KeepAliveMixin(
                  key: widget.bodyKey,
                  child: body,
                ),
              ],
              //wrap values in keep alives
              addAutomaticKeepAlives: true,

              //If the children are easy to repaint
              //it might be more efficient to not add a repaint boundary
              //and simply repaint the children during scrolling
              //BUT our children are most gifs and not simple
              addRepaintBoundaries: false,

              //Typically, children in a scrolling container
              //must be annotated with a semantic index in order to generate
              //the correct accessibility announcements
              //addSemanticIndexes: true,
            ),
          ),
        );
      } else {
        return SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              header,
              body,
            ],
          ),
        );
      }
    } else {
      return StickyHeader(
        header: header,
        content: body,
      );
    }
  }
}
