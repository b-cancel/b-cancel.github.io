import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/utils/wrappedText.dart';

class TopIntro extends StatelessWidget {
  const TopIntro({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
            fontSize: MyApp.h6,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 8,
              ),
              child: WrappedText(
                "O:\\User\\I_AM_",
                pattern: "\\",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({
    Key key,
    this.isTiny: false,
  }) : super(key: key);

  final bool isTiny;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.white,
        fontSize: isTiny ? MyApp.h3 : MyApp.h1,
      ),
      child: Text(
        "Bryan_Cancel",
        style: TextStyle(
        ),
      ),
    );
  }
}

class Joke extends StatelessWidget {
  const Joke({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Colors.white,
        fontSize: MyApp.h5,
        height: 1,
      ),
      child: WrappedText(
        "> echo \"yes... like cancel my order of fries :P\"",
      ),
    );
  }
}

class RightsFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
      ),
      child: Center(
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: MyApp.h6,
            color: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Text("All Rights Reserved @ 2020\n"),
              Text("Inspired By IDEs Everywhere"),
              Text("Developed And Designed"),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("by "),
                  Text(
                    "Bryan Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text("using Dart/Flutter"),
            ],
          ),
        ),
      ),
    );
  }
}