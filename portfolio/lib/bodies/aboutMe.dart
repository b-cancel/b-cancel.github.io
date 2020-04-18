//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:google_fonts/google_fonts.dart';

//internal
import 'package:portfolio/utils/wrappedText.dart';

//widget
class AboutMeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isPortrait = size.height > size.width;
    if (isPortrait) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: Face()),
              Center(child: Hello()),
              Center(child: Logo()),
            ],
          ),
          Container(
            child: Flexible(
              child: Introduction(),
            ),
          )
        ],
      );
    } else {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Face(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hello(),
                  Logo(),
                  Introduction(),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

class Face extends StatelessWidget {
  const Face({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        16.0,
      ),
      child: Image.asset(
        "assets/face/white.png",
        width: 250,
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: Image.asset(
        "assets/title/small.gif",
        width: 350,
      ),
    );
  }
}

class Hello extends StatelessWidget {
  const Hello({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hi! I'm Bryan Cancel",
      style: GoogleFonts.robotoMono(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Introduction extends StatelessWidget {
  const Introduction({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        WrappedText(
          "I recently graduated with my Bachelors in Computer Science." +
              " After graduation I traveled Europe, came back and a disaster struck!" +
              " So I had the privaledge to help in Disaster Releif efforts full time for 3 to 4 months; " +
              " repairing drywall, roofs, and anything else that needed fixing.",
        ),
        Text("\n"),
        WrappedText(
          "I just finished publishing my first app \"Swol\", and I'm excited for my next Adventure!",
        ),
      ],
    );
  }
}
