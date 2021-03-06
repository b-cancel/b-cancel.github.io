//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/icons/portfolio_icons_icons.dart';

//internal
import 'package:portfolio/bodies/toolkit/icons.dart';
import 'package:portfolio/section/section.dart';
import 'package:portfolio/section/uncollapsible.dart';
import 'package:portfolio/utils/link/ui/hover.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';

//other
String highXP = "experienced";
String normalXP = "competent";
String lowXP = "familiar";
List<String> experiences = [
  highXP,
  normalXP,
  lowXP,
];

class ToolsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        experienceToTools.length,
        (int experienceIndex) {
          String label = experiences[experienceIndex];
          List<Tool> tools = experienceToTools[label];
          return CollapsibleSection(
            label: "\"" + label + "\"",
            labelColor: Colors.white,
            separator: " =>",
            initiallyOpened: label != lowXP,
            sectionType: SectionType.Brackets,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 16,
              runSpacing: 8,
              children: List.generate(
                tools.length,
                (int toolIndex) {
                  Tool thisTool = tools[toolIndex];
                  return IconLabelLink(
                    icon: ColorizeLinkOnHover(
                      icon: thisTool.icon,
                      color: thisTool.color,
                      symbol: thisTool.iconSymbol,
                      padding: thisTool.icon == PortfolioIcons.unity ? EdgeInsets.only(
                        left: 10,
                        right: 14,
                        //vertical
                        top: 12,
                        bottom: 12,
                      ) : EdgeInsets.all(12),
                    ),
                    label: thisTool.label,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
