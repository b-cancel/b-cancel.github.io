//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:google_fonts/google_fonts.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/menu.dart';
import 'package:portfolio/region/regions.dart';
import 'package:portfolio/region/regularRegion.dart';
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
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
  Logo({
    Key key,
  }) : super(key: key);

  getLongestString(List<String> strings) {
    String longestFirst = "";
    for (int i = 0; i < strings.length; i++) {
      if (strings[i].length > longestFirst.length) {
        longestFirst = strings[i];
      }
    }
    return longestFirst;
  }
  
  final ValueNotifier<int> firstVN = new ValueNotifier<int>(0);
  final ValueNotifier<int> secondVN = new ValueNotifier<int>(0);

  Duration delay = Duration(milliseconds: 1700);
  Duration animation = Duration(milliseconds: 300);
  startShuffle()async{
    await Future.delayed(delay);
    secondVN.value ++;
    await Future.delayed(delay);
    firstVN.value ++;
    await Future.delayed(delay);
    firstVN.value ++;
    await Future.delayed(delay);
    secondVN.value ++;
    await Future.delayed(delay);
    firstVN.value ++;
    secondVN.value --;
    await Future.delayed(delay);
    secondVN.value ++;
    await Future.delayed(delay);
    firstVN.value ++;
    await Future.delayed(delay);
    firstVN.value = 0;
    secondVN.value = 0;
    startShuffle();
  }

  @override
  Widget build(BuildContext context) {
    startShuffle();

    //items to shuffle through
    List<String> first = ["Software", "App", "Web", "Game", "UX"];
    String longestFirst = getLongestString(first);
    List<String> second = ["Engineer", "Developer", "Designer"];
    String longestSecond = getLongestString(second);

    //return
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      child: DefaultTextStyle(
        style: GoogleFonts.robotoMono(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: MyApp.h3,
        ),
        child: ClipRRect(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "I'm a ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              //Software, App, Web, Game, UX
              Container(
                color: MyApp.highlightGreen,
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0, 
                      child: Text(longestFirst),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: List.generate(
                        first.length,
                        (index) {
                          return AnimatedTitle(
                            vn: firstVN, 
                            text: first[index], 
                            index: index,
                            fontSize: MyApp.h3,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //Engineer, Developer, Designer
              Container(
                color: MyApp.highlightPink,
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0, 
                      child: Text(longestSecond),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: List.generate(
                        second.length,
                        (index) {
                          return AnimatedTitle(
                            vn: secondVN, 
                            text: second[index], 
                            index: index,
                            fontSize: MyApp.h3,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      /*
      Image.asset(
        "assets/title/small.gif",
        width: 350,
      ),*/
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  AnimatedTitle({
    @required this.vn,
    @required this.text,
    @required this.index,
    @required this.fontSize,
  });

  final ValueNotifier<int> vn;
  final String text;
  final int index;
  final double fontSize;

  double valueToPosition(ValueNotifier<int> vn){
    if(vn.value == index){
      return 0;
    }
    else{
      if(vn.value > index){
        return -1;
      }
      else{
        return 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //set whatever end was to begin
      //set new end
      //so trigger animation on end
      animation: vn, 
      builder: (context, child) {
        return AnimatedContainer(
          duration: kTabScrollDuration,
          transform: Matrix4Transform().translate(
            y: valueToPosition(vn) * (fontSize * 2),
          ).matrix4,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
            ),
          ),
        );
      },
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
        /*
        RegularRegion(
          title: "My Story", 
          titleColor: MyApp.oldPurple,
          fontSize: MyApp.h4,
          body: Column(
            children: <Widget>[
              Text("my story will be here or something")
            ],
          ),
        ),
        */
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
                    onTap: () {
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
