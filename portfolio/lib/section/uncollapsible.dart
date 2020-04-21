import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';

class UnCollapsibleSection extends StatelessWidget {
  UnCollapsibleSection({
    @required this.label,
    this.separator: ":",
    @required this.sectionType,
    @required this.child,
  });

  final String label;
  final String separator;
  final SectionType sectionType;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label + separator + " " + sectionTypeToLeft[sectionType],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24,
          ),
          child: child,
        ),
        Text(
          sectionTypeToRight[sectionType] + ", ",
        ),
      ],
    );
  }
}
