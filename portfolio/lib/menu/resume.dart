import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu/expandingText.dart';
import 'package:portfolio/menu/myWorkTitle.dart';

class ResumeInfo extends StatelessWidget {
  const ResumeInfo({
    Key key,
    @required this.minWidth,
    @required this.maxWidth,
  }) : super(key: key);

  final double minWidth;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    //NOTE: can't smart refresh from here and keep the menu scaling as desired
    //also there really is no reason why they would be reloading from here
    //everything should always load in properly
    return SingleChildScrollView(
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
          ExpandMyWorkOnHover(
            minWidth: minWidth,
            maxWidth: maxWidth,
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
