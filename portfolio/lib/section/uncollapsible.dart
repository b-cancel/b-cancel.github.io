import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/section/section.dart';

class UnCollapsibleSection extends StatelessWidget {
  UnCollapsibleSection({
    @required this.label,
    this.labelColor: MyApp.oldGrey,
    this.separator: ":",
    @required this.sectionType,
    @required this.child,
  });

  final String label;
  final Color labelColor;
  final String separator;
  final SectionType sectionType;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: <Widget>[
            Text(
              label,
              style: GoogleFonts.robotoMono(
                color: labelColor,
              )
            ),
            Text(
              separator + " " +sectionTypeToLeft[sectionType],
              style: GoogleFonts.robotoMono(
                color: MyApp.oldGrey,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 24,
          ),
          child: child,
        ),
        Text(
          sectionTypeToRight[sectionType] + ", ",
          style: GoogleFonts.robotoMono(
            color: MyApp.oldGrey,
          ),
        ),
      ],
    );
  }
}
