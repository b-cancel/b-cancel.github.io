import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/region/regions.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/utils/conditional.dart';

class CollapsibleSection extends StatefulWidget {
  CollapsibleSection({
    @required this.label,
    this.labelColor: MyApp.oldGrey,
    this.separator: ":",
    this.fontSize: MyApp.h4,
    @required this.sectionType,
    @required this.child,
    this.initiallyOpened: true,
    this.allowCollapsing: true,
    this.leftPadding: true,
  });

  final String label;
  final Color labelColor;
  final String separator;
  final double fontSize;
  final SectionType sectionType;
  final Widget child;
  final bool initiallyOpened;
  final bool allowCollapsing;
  final bool leftPadding;

  @override
  _CollapsibleSectionState createState() => _CollapsibleSectionState();
}

class _CollapsibleSectionState extends State<CollapsibleSection> {
  final ValueNotifier<bool> isOpened = new ValueNotifier<bool>(false);

  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    isOpened.value = widget.initiallyOpened;
    isOpened.addListener(updateState);
    isOpened.addListener(tellSystem);
  }

  @override
  void dispose() {
    isOpened.removeListener(tellSystem);
    isOpened.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header = Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: 8,
        ),
        child: Wrap(
        children: <Widget>[
          Text(
            widget.label,
            style: GoogleFonts.robotoMono(
              color: widget.labelColor,
              fontSize: widget.fontSize,
            ),
          ),
          Text(
            widget.separator + " " + sectionTypeToLeft[widget.sectionType],
            style: GoogleFonts.robotoMono(
              color: MyApp.oldGrey,
              fontSize: widget.fontSize,
            ),
          ),
          Visibility(
            visible: isOpened.value == false,
            child: Text(
              "+" + sectionTypeToRight[widget.sectionType] + ",",
              style: GoogleFonts.robotoMono(
                color: MyApp.oldGrey,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ],
    ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: Ternary(
            condition: widget.allowCollapsing,
            isTrue: InkWell(
              onTap: () {
                isOpened.value = !isOpened.value;
              },
              child: header,
            ),
            isFalse: header,
          ),
        ),
        Visibility(
          visible: isOpened.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: widget.leftPadding ? 24 : 0,
                ),
                child: widget.child,
              ),
              Text(
                sectionTypeToRight[widget.sectionType] + ", ",
                style: GoogleFonts.robotoMono(
                  color: MyApp.oldGrey,
                  fontSize: widget.fontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
