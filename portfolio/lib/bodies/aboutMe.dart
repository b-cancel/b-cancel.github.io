//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu.dart';
import 'package:portfolio/region/regions.dart';
import 'package:portfolio/utils/link/ui/hover.dart';

//internal
import 'package:portfolio/utils/wrappedText.dart';

//widget
class AboutMeBody extends StatelessWidget {
  AboutMeBody({
    @required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 750) {
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
              child: Introduction(
                scrollController: scrollController,
              ),
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
                  Introduction(
                    scrollController: scrollController,
                  ),
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
    @required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        WrappedText(
          "I recently graduated with my Bachelors in Computer Science." +
              " After graduation I traveled Europe, came back, and a disaster struck!" +
              " So I had the privaledge to help in Disaster Releif efforts full time for 3 to 4 months; " +
              " repairing drywall, roofs, and anything else that needed fixing.",
        ),
        Text("\n"),
        WrappedText(
          "I just finished publishing my first app \"Swol\", and I'm excited for my next Adventure!",
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 24.0,
              ),
              child: OpaqueOnHover(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: MyApp.oldGrey,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 8,
                            ),
                            child: Text(
                              "Quick Links",
                              style: GoogleFonts.robotoMono(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Icon(
                              Icons.subdirectory_arrow_left,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: (){
                      int contactID = regions.length - 1;
                      scrollToRegion(
                        contactID,
                        scrollController,
                      );
                    },
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
