import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';

class RightsFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        bottom: 56,
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
