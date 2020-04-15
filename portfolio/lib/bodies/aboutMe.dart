import 'package:flutter/material.dart';

class AboutMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Image.asset(
                "assets/face/white.png",
                width: 250,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Image.asset(
                "assets/title/small.gif",
                width: 350,
              ),
            ),
          ],
        ),
        Container(
          child: Flexible(
            child: Text(
              "Hi! I'm Bryan Cancel\n\n"
              //-------------------------
              + "I recently graduated with my Bachelors in Computer Science."
              + " After graduation I traveled Europe, came back and a disaster struck!"
              + " So I had the privaledge to help in Disaster Releif efforts full time for 3 to 4 months; "
              + " repairing drywall, roofs, and anything else that needed fixing.\n\n"
              //-------------------------
              + "I just finished publishing my first app \"Swol\", and I'm excited for my next Adventure!",
            ),
          )
        )
      ],
    );
  }
}