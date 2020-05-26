//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/conditional.dart';

//this slides in at the last second of the menu hiding
//and even if it didn't the menu will be stoppping it from being tappable
class MenuOpener extends StatelessWidget {
  const MenuOpener({
    Key key,
    @required this.openMenu,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: openMenu,
      child: IconButton(
        icon: Icon(
          PortfolioIcons.file_alt,
        ),
        onPressed: () {
          if (openMenu.value == false) {
            openMenu.value = true;
          }
        },
      ),
      builder: (context, child) {
        return AnimatedOpacity(
          opacity: openMenu.value ? 0 : 1,
          duration: kTabScrollDuration,
          child: child,
        );
      },
    );
  }
}

//may or may not create a button
class MenuCloser extends StatelessWidget {
  const MenuCloser({
    Key key,
    this.openMenu,
    this.child,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.75),
      child: Ternary(
        condition: openMenu != null,
        isTrue: InkWell(
          onTap: () {
            if (openMenu.value) {
              openMenu.value = false;
            }
          },
          child: child ?? Container(),
        ),
        isFalse: Container(),
      ),
    );
  }
}

//isn't tappable to avoid issues
//but still animates opacity so it blend it with the button that does the same
class ScrimBehindMovingMenu extends StatelessWidget {
  const ScrimBehindMovingMenu({
    Key key,
    @required this.openMenu,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: AnimatedOpacity(
        duration: kTabScrollDuration,
        opacity: openMenu.value ? 1 : 0,
        child: SizedBox.expand(
          child: MenuCloser(),
        ),
      ),
    );
  }
}

//actually tapable section that works with the section above
class MyWorkMenuCloseButton extends StatelessWidget {
  const MyWorkMenuCloseButton({
    Key key,
    @required this.openMenu,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: kTabScrollDuration,
      opacity: openMenu.value ? 1 : 0,
      child: SizedBox.expand(
        child: MenuCloser(
          openMenu: openMenu,
          child: DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MyApp.h4,
            ),
            child: Center(
              child: Text(
                "M\nY\n\nW\nO\nR\nK",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}