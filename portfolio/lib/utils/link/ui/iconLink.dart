//flutter
import 'package:flutter/material.dart';

//internal: ui
import 'package:portfolio/utils/link/ui/linkOptions.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

//widget
class IconLabelLink extends StatelessWidget {
  IconLabelLink({
    @required this.icon,
    this.label,
    this.lightMode: true,
  });

  final Widget icon;
  final String label;
  final bool lightMode;

  @override
  Widget build(BuildContext context) {
    Function onShowLabel = () {
      showOptions(
        context,
        lightMode: lightMode,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              label ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    };

    //build
    return IconLink(
      onTap: () {
        onShowLabel();
      },
      onShowOptions: () {
        onShowLabel();
      },
      addOpaqueOnHover: false,
      addColorizeOnHover: true,
      icon: icon,
      lightMode: lightMode,
    );
  }
}

class IconLink extends StatelessWidget {
  const IconLink({
    Key key,
    @required this.onTap,
    this.onShowOptions,
    @required this.icon,
    this.addOvalClipper: true,
    this.addOpaqueOnHover: true,
    this.addColorizeOnHover: false,
    @required this.lightMode,
  }) : super(key: key);

  final Function onTap;
  final Function onShowOptions;
  final Widget icon;
  final bool addOvalClipper;
  final bool addOpaqueOnHover;
  final bool addColorizeOnHover;
  final bool lightMode;

  @override
  Widget build(BuildContext context) {
    Widget inkWell = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap();
        },
        onHover: (h) {
          onShowOptions();
        },
        onDoubleTap: () {
          onShowOptions();
        },
        onLongPress: () {
          onShowOptions();
        },
        child: icon,
      ),
    );

    inkWell = Theme(
      data: lightMode ? ThemeData.light() : ThemeData.dark(),
      child: inkWell,
    );

    if (addOvalClipper) {
      inkWell = ClipOval(
        child: inkWell,
      );
    }

    if (addOpaqueOnHover) {
      return OpaqueOnHover(
        invert: lightMode,
        child: inkWell,
      );
    } else {
      return inkWell;
    }
  }
}
