import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

//options tool bar for links
//should be used for text link and icons links
showOptions(
  BuildContext context, {
  List<Widget> children,
  PreferDirection preferDirection: PreferDirection.topCenter,
}) {
  BotToast.showAttachedWidget(
    targetContext: context,
    preferDirection: preferDirection,
    duration: Duration(days: 1),
    enableSafeArea: true,
    onlyOne: true,
    attachedBuilder: (_) {
      return Card(
        color: MyApp.headerColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      );
    },
  );
}

class OptionButton extends StatelessWidget {
  OptionButton({
    this.icon,
    this.label,
    this.onTap,
    this.addBorder: false,
  });

  final IconData icon;
  final String label;
  final Function onTap;
  final bool addBorder;

  @override
  Widget build(BuildContext context) {
    if (icon == null && label == null) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      Widget button = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Visibility(
                  visible: icon != null,
                  child: Icon(
                    icon,
                  ),
                ),
                Visibility(
                  visible: icon != null && label != null,
                  child: Container(
                    width: 8,
                    height: 2,
                  ),
                ),
                Visibility(
                  visible: label != null,
                  child: Text(
                    label ?? "",
                    style: GoogleFonts.robotoMono(
                      fontWeight:
                          addBorder ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: addBorder ? MyApp.oldGrey : MyApp.inactiveTabColor,
            width: 2,
            height: 8 + (addBorder ? 18.0 : 8) + 8,
          ),
        ],
      );

      //make it actionable if we have on top
      if (onTap != null) {
        return OpaqueOnHover(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: onTap, //might be null
                child: button),
          ),
        );
      } else {
        return button;
      }
    }
  }
}
