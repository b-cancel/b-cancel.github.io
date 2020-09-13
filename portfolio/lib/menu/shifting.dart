//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu/expandingText.dart';
import 'package:portfolio/utils/goldenRatio.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/menu/titleShuffle.dart';
import 'package:portfolio/data/basic.dart';
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
      //ugly border that wont blend into my gradient
      shadowColor: Colors.transparent,
      type: MaterialType.canvas,
      borderOnForeground: false,
      elevation: 0,
      //build
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
        ),
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
                child: MyName(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  //When this is true, the scroll view is scrollable
                  //even if it does not have sufficient content to actually scroll
                  primary: true,
                  //iOS feel
                  physics: BouncingScrollPhysics(),
                  //atleast spacing to match name
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  //children
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //NOTE: we start spreaded when the section starts open
                      ExpandingSection(
                        title: "Experience",
                        startOpen: true,
                      ),
                      ExpandingSection(
                        title: "Education",
                        startOpen: true,
                      ),
                      Material(
                        color: Colors.black,
                        child: InkWell(
                          onTap: () {
                            if (Home.openMenu.value) {
                              Home.openMenu.value = false;
                            }
                          },
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: minWidth,
                              maxWidth: maxWidth,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            height: 56,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                DefaultTextStyle(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  child: SectionTitle(
                                    title: "My Work",
                                    padded: false,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 8,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Icon(
                                      Icons.arrow_right,
                                      color: Colors.white,
                                      size: MyApp.h2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ExpandingSection(
                        title: "Software",
                        startOpen: true,
                      ),
                      ExpandingSection(
                        title: "Languages",
                        startOpen: true,
                      ),
                      LanguageBody(),
                      ExpandingSection(
                        title: "Awards",
                        startOpen: false,
                      ),
                      ExpandingSection(
                        title: "References",
                        startOpen: false,
                      ),
                      ExpandingSection(
                        title: "Contact",
                        startOpen: false,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageBody extends StatelessWidget {
  const LanguageBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0 + 16,
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: MyApp.h4,
          color: Colors.black,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("English"),
            Text(
              " && ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("Spanish"),
          ],
        ),
      ),
      /*Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "English",
                style: TextStyle(
                  fontSize: MyApp.h4,
                ),
              ),
              CanRead(),
              CanWrite(),
              CanSpeak(),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "Spanish",
                style: TextStyle(
                  fontSize: MyApp.h4,
                ),
              ),
              CanRead(),
              CanSpeak(),
              Text(
                ">",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MyApp.h3
                ),
              ),
              CanWrite(),
            ],
          )
        ],
      ),
      */
    );
  }
}

class CanSpeak extends StatelessWidget {
  const CanSpeak({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconLabelLink(
      label: "speak",
      icon: IconLinkIcon(
        mini: true,
        icon: PortfolioIcons.volume_up,
      ),
    );
  }
}

class CanWrite extends StatelessWidget {
  const CanWrite({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconLabelLink(
      label: "write",
      icon: IconLinkIcon(
        mini: true,
        icon: PortfolioIcons.pen_alt,
      ),
    );
  }
}

class CanRead extends StatelessWidget {
  const CanRead({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconLabelLink(
      label: "read",
      icon: IconLinkIcon(
        mini: true,
        icon: PortfolioIcons.book_reader,
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    this.padded: true,
  }) : super(key: key);

  final String title;
  final bool padded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padded ? 16 : 0,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          bottom: 8.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: MyApp.h4,
            fontWeight: FontWeight.w900,
            letterSpacing: 8,
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
