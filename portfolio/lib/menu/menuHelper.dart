import 'package:flutter/material.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/main.dart';

class GradientBorder extends StatelessWidget {
  const GradientBorder({
    Key key,
    @required this.baseColor,
  }) : super(key: key);

  final Color baseColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Home.startUpComplete.value ? kTabScrollDuration : Duration.zero,
      opacity: Home.openMenu.value ? 1 : 0,
      child: Container(
        //minimum size of close menu button
        width: Home.appBarSize / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [baseColor, baseColor.withOpacity(0)],
            stops: [0.0, 1.0],
          ),
        ),
        child: SizedBox.expand(
          child: Container(),
        ),
      ),
    );
  }
}

class VerticalMyWorkLabel extends StatelessWidget {
  const VerticalMyWorkLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox.expand(
        child: Center(
          child: AnimatedContainer(
            duration:
                Home.startUpComplete.value ? kTabScrollDuration : Duration.zero,
            transform: Matrix4.translationValues(
              (Home.openMenu.value) ? 0 : (getMenuWidth() ?? 0),
              0,
              0,
            ),
            child: AnimatedOpacity(
              duration: Home.startUpComplete.value
                  ? kTabScrollDuration
                  : Duration.zero,
              opacity: Home.openMenu.value ? 1 : 0,
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "M\nY\n\nW\nO\nR\nK",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MyApp.h4,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ModalBarrierCloser extends StatelessWidget {
  const ModalBarrierCloser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (Home.openMenu.value) {
            Home.openMenu.value = false;
            setMenuOpenCookie(false);
          }
        },
      ),
    );
  }
}
