//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/menu/helper.dart';
import 'package:portfolio/menu/shifting.dart';
import 'package:portfolio/utils/goldenRatio.dart';
import 'package:portfolio/home.dart';

//widget
class ResumeInMenu extends StatefulWidget {
  const ResumeInMenu({
    Key key,
    @required this.menuKey,
    @required this.openMenu,
  }) : super(key: key);

  final GlobalKey menuKey;
  final ValueNotifier<bool> openMenu;

  @override
  _ResumeInMenuState createState() => _ResumeInMenuState();
}

class _ResumeInMenuState extends State<ResumeInMenu> {
  updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.openMenu.addListener(updateState);
  }

  @override
  void dispose() {
    widget.openMenu.removeListener(updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    //keep it nice and satisfying at all times
    double minWidth = toGoldenRatioSmall(
      screenWidth,
    );

    //compromise golden ratio when small for cool transition effect
    double maxWidth = screenWidth - 56;

    //build
    return Container(
      height: screenHeight,
      width: screenWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ScrimBehindMovingMenu(
                openMenu: widget.openMenu,
              ),
              AnimatedContainer(
                height: MediaQuery.of(context).size.height,
                duration: kTabScrollDuration,
                transform: Matrix4.translationValues(
                  (widget.openMenu.value) ? 0 : -getMenuWidth(),
                  0,
                  0,
                ),
                child: ShiftingMenu(
                  openMenu: widget.openMenu,
                  minWidth: minWidth,
                  maxWidth: maxWidth,
                ),
              ),
            ],
          ),
          Expanded(
            child: MyWorkMenuCloseButton(
              openMenu: widget.openMenu,
            ),
          ),
        ],
      ),
    );
  }
}


