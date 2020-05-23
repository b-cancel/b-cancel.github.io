import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/bodies/toolkit/icons.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/conditional.dart';

class ToolsSection extends StatelessWidget {
  toolListToWidget(List<Tool> tools) {
    List<Widget> widgets = new List<Widget>();
    for (int i = 0; i < tools.length; i++) {
      Tool thisTool = tools[i];
      widgets.add(
        AToolWidget(
          thisTool: thisTool,
        ),
      );
    }

    //return within wrap
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 16,
      runSpacing: 8,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        experienceToTools.length,
        (index) {
          //get label
          String label;
          switch (index) {
            case 0:
              label = "a lot";
              break;
            case 1:
              label = "competent";
              break;
            default:
              label = "a little";
              break;
          }

          //make section
          return CollapsibleSection(
            label: "\"" + label + "\"",
            labelColor: Colors.white,
            separator: " =>",
            initiallyOpened: label != "a little",
            sectionType: SectionType.Brackets,
            child: toolListToWidget(
              experienceToTools[label],
            ),
          );
        },
      ).toList(),
    );
  }
}

class AToolWidget extends StatelessWidget {
  const AToolWidget({
    Key key,
    @required this.thisTool,
    this.items,
  }) : super(key: key);

  final Tool thisTool;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    //handle image
    Widget image;
    if (thisTool.altSvgIcon != null) {
      if (thisTool.altSvgIcon.contains("assets")) {
        image = Image.asset(
          thisTool.altSvgIcon,
        );
      } else {
        image = Image.network(
          thisTool.altSvgIcon,
        );
      }
    }

    //handle description
    //handle options items of tool
    List<Widget> items = new List<Widget>();

    //handle description (basically)
    if (thisTool.usedFor != null) {
      items.add(
        Wrap(
          children: [
            Text(
              "used For: ",
            ),
            Text(
              thisTool.usedFor,
            ),
          ],
        ),
      );
    }

    //handlee helper tools
    List<Tool> helperTools = thisTool.usedWith;
    if (helperTools != null) {
      List<Widget> helperToolWidgets = new List<Widget>();
      for (int index = 0; index < helperTools.length; index++) {
        helperToolWidgets.add(
          AToolWidget(
            thisTool: helperTools[index],
          ),
        );
      }
      items.add(CollapsibleSection(
        allowCollapsing: false,
        label: "with",
        separator: ":",
        sectionType: SectionType.Brackets,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: helperToolWidgets,
        ),
      ));
    }

    //return it all
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      children: <Widget>[
        Visibility(
          visible: thisTool.altSvgIcon != null,
          child: Padding(
            padding: EdgeInsets.only(
              top: 4,
              right: 4,
            ),
            child: Container(
              height: 56,
              width: 56,
              padding: EdgeInsets.all(
                8,
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(thisTool.icon),
              ),
            ),
          ),
        ),
        Ternary(
          condition: items.length != 0,
          isTrue: CollapsibleSection(
            labelColor: Colors.white,
            label: thisTool.language,
            separator: "",
            allowCollapsing: false,
            sectionType: SectionType.Parenthesis,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items,
            ),
          ),
          isFalse: Text(
            thisTool.language + ",",
            style: GoogleFonts.robotoMono(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
