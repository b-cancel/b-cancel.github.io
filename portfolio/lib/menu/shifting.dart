//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/menu/resume.dart';
import 'package:portfolio/utils/goldenRatio.dart';
import 'package:portfolio/home.dart';

//main menu widget
class ShiftingMenu extends StatelessWidget {
  const ShiftingMenu({
    Key key,
    @required this.minWidth,
    @required this.maxWidth,
  }) : super(key: key);

  final double minWidth;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    double theWidth = MediaQuery.of(context).size.width;
    double minPadding = 16.0 * 2;

    //first split
    double usableWidth = theWidth - minPadding;
    double bigUsable = toGoldenRatioBig(usableWidth);
    double smallUsable = usableWidth - bigUsable;

    //second split
    double biggerPartOfSmallUsable = toGoldenRatioBig(smallUsable);
    double smallerPartOfSmallUsable = smallUsable - biggerPartOfSmallUsable;

    //print
    print(usableWidth.toString() +
        " = " +
        bigUsable.toString() +
        " + " +
        smallUsable.toString());
    print(smallUsable.toString() +
        " = " +
        biggerPartOfSmallUsable.toString() +
        " + " +
        smallerPartOfSmallUsable.toString());

    //build
    return Material(
      color: Colors.white,
      //ugly border that wont blend into my gradient
      shadowColor: Colors.transparent,
      type: MaterialType.canvas,
      borderOnForeground: false,
      elevation: 0,
      //build
      //890 is our magic number
      //below it we go with it or the maxWidth
      //above it we go with max width
      child: Container(
        width: MediaQuery.of(context).size.width > 890
            ? minWidth
            : (toGoldenRatioSmall(890) < maxWidth
                ? toGoldenRatioSmall(890)
                : maxWidth),
        child: Container(
          key: menuKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AnimatedContainer(
                duration: Home.startUpComplete.value
                    ? kTabScrollDuration
                    : Duration.zero,
                transform: Matrix4.translationValues(
                  (Home.openMenu.value) ? 0 : (getMenuWidth() ?? 0),
                  0,
                  0,
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  child: MyName(),
                ),
              ),
              Expanded(
                child: ResumeInfo(
                  minWidth: minWidth,
                  maxWidth: maxWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoldenRatioGuide2 extends StatelessWidget {
  const GoldenRatioGuide2({
    Key key,
    @required this.usableWidth,
    @required this.bigUsable,
    @required this.smallUsable,
  }) : super(key: key);

  final double usableWidth;
  final double bigUsable;
  final double smallUsable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      color: Colors.red,
      height: 16,
      width: usableWidth,
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.blue,
            height: 16,
            width: bigUsable,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  color: Colors.green,
                  height: 16,
                  width: smallUsable,
                ),
                Spacer(),
              ],
            ),
          ),
          /*
          Container(
            color: Colors.green,
            height: 16,
            width: smallUsable,
          ),
          */
          Spacer(),
        ],
      ),
    );
  }
}

class GoldenRatioGuide extends StatelessWidget {
  const GoldenRatioGuide({
    Key key,
    @required this.usableWidth,
    @required this.bigUsable,
    @required this.smallerPartOfSmallUsable,
  }) : super(key: key);

  final double usableWidth;
  final double bigUsable;
  final double smallerPartOfSmallUsable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        color: Colors.red,
        height: 16,
        width: usableWidth,
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.blue,
              height: 16,
              width: bigUsable,
            ),
            Container(
              color: Colors.green,
              height: 16,
              width: smallerPartOfSmallUsable,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
