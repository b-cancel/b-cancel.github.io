//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/bodies/projects/projects.dart';

//widget
class GraphicDesign extends StatelessWidget {
  const GraphicDesign({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DevelopmentSection(
      initiallyOpened: false,
      label: "Graphic Design",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 24.0 + 24 + 8,
              right: 24,
            ),
            child: Text(
              "//More Graphic Design and User Experience Work can be found in the development sections above",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          ProjectSection(
            label: "University Transportation Center for Railway Safety",
            description: "Some of the work I designed during my time at the UTCRS."
            + "\nThe Top Link will take you to the interactive module I made for the summer camp using Articulate software.",
            livePage: "https://b-cancel.github.io/Online_Learning_Module_for_UTCRS/story_html5.html",
            initiallyOpened: true,
            imageUrls: [
              //poster
              "https://imgur.com/wsBPkTC.jpg",
              "https://imgur.com/MeUNQI0.jpg",
              //holidays
              "https://imgur.com/CPN3e7n.jpg",
              //module layouts,
              "https://imgur.com/UQ9PRdp.jpg",
              "https://imgur.com/Y6jmoM2.jpg",
              //ppt formats
              "https://imgur.com/kHoyAhQ.jpg",
              "https://imgur.com/Xe1KyU9.jpg",
            ],
          ),
          ProjectSection(
            label: "Miscellaneous Projects",
            description: "Miscellanous work from college projects, "
            + "high school projects, "
            + "and some work I did for fun!",
            initiallyOpened: true,
            imageUrls: [
              "https://imgur.com/q8NMp8w.jpg", //tech com brochure
              "https://imgur.com/HdkrlxN.jpg", //desperate times
              "https://imgur.com/iIkfZWa.jpg", //abby
              "https://imgur.com/yWOItgG.jpg", //B
              "https://imgur.com/PstIwbm.jpg", //tech com poster
              "https://imgur.com/zyEPrxO.jpg", //business card
              "https://imgur.com/6htRkMl.jpg", //tech half day program
              "https://imgur.com/j1QR36t.jpg", //tech com logo
              "https://imgur.com/zYcdAoN.jpg", //buiness card BETA
              "https://imgur.com/rfzfxWd.jpg", //monster v aliens
              "https://imgur.com/bd46XuW.jpg", //delta pong
              "https://imgur.com/iUsVQSS.jpg", //naruto

            ],
          ),
        ],
      ),
    );
  }
}