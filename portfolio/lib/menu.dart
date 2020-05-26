//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/home.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';

//only allows opening once the menu is fully closed
//but fades in and out as intent is communicated
class OpenMenuButton extends StatelessWidget {
  const OpenMenuButton({
    Key key,
    @required this.menuWantsToBeOpened,
    @required this.menuIsOpened,
  }) : super(key: key);

  final ValueNotifier<bool> menuWantsToBeOpened;
  final ValueNotifier<bool> menuIsOpened;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: menuIsOpened,
      child: IconButton(
        icon: Icon(
          PortfolioIcons.file_alt,
        ),
        onPressed: () {
          if (menuIsOpened.value == false) {
            menuIsOpened.value = true;
          }
        },
      ),
      builder: (context, child) {
        return AnimatedOpacity(
          opacity: menuWantsToBeOpened.value ? 1 : 0,
          duration: kTabScrollDuration,
          child: child,
        );
      },
    );
  }
}

//widget
class ResumeInMenu extends StatelessWidget {
  const ResumeInMenu({
    Key key,
    @required this.menuKey,
    @required this.isMenuOpened,
  }) : super(key: key);

  final GlobalKey menuKey;
  final ValueNotifier<bool> isMenuOpened;

  //build
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Visibility(
            visible: isMenuOpened.value,
            //NOTE: here the whole thing is a button
            //but the text should immediately appear where it will be
            //so users can quickly read it while things are animating
            child: Positioned.fill(
              child: Material(
                color: Colors.black.withOpacity(.75),
                child: InkWell(
                  onTap: () {
                    isMenuOpened.value = false;
                  },
                  child: Container(),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: kTabScrollDuration,
                transform: Matrix4.translationValues(
                  (isMenuOpened.value) ? 0 : -getMenuWidth(),
                  0,
                  0,
                ),
                child: Material(
                  child: Container(
                    color: Colors.red,
                    key: menuKey,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text("resume and such"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Center(
                    child: Icon(
                      PortfolioIcons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
