//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/utils/conditional.dart';
import 'package:shared_preferences/shared_preferences.dart';

//plugin
import 'package:universal_html/html.dart';
import 'package:swipedetector/swipedetector.dart';

//internal: other
import 'package:portfolio/contact.dart';
import 'package:portfolio/menu/menu.dart';
import 'package:portfolio/myWork.dart';
import 'package:portfolio/main.dart';

//function used for main page and menu shifting
final GlobalKey menuKey = GlobalKey();
double getMenuWidth() {
  final keyContext = menuKey?.currentContext;
  if (keyContext != null) {
    final box = keyContext.findRenderObject() as RenderBox;
    return box?.size?.width;
  } else {
    return null;
  }
}

setMenuOpenCookie(bool newValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('menuOpened', newValue);
}

//widgets
class Home extends StatelessWidget {
  //the menu MUST start off open
  static final ValueNotifier<bool> openMenu = new ValueNotifier<bool>(
    true,
  );

  static final ValueNotifier<bool> startUpComplete = new ValueNotifier(
    false,
  );

  //build
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Theme(
            data: ThemeData.dark(),
            child: Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: CustomAppBarTitle(),
              ),
              //NOTE: transition handled internally
              body: MyWork(),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: UnderConstructionChip(),
          ),
          Positioned.fill(
            //NOTE: transition handled internally
            child: SwipeDetector(
              onSwipeLeft: () {
                if (Home.openMenu.value) {
                  Home.openMenu.value = false;
                  setMenuOpenCookie(false);
                }
              },
              child: ResumeInMenu(
                menuKey: menuKey,
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: AnimatedBuilder(
              animation: startUpComplete,
              builder: (context, child) {
                return AnimatedContainer(
                  duration: kTabScrollDuration,
                  color: startUpComplete.value
                      ? Colors.transparent
                      : Color(0xFF030303),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UnderConstructionChip extends StatelessWidget {
  const UnderConstructionChip({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Text(
          "Under Construction",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//NOTE: must be the same for both appbar and the menu
//so that you get the cool transition effect
class MyName extends StatelessWidget {
  const MyName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle nameStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: MyApp.h2,
      letterSpacing: 2,
    );

    //415, 428, 560
    bool largerThanIDK = MediaQuery.of(context).size.width > 560;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: Home.openMenu == null
            ? null
            : () async {
                if (Home.openMenu.value == false) {
                  Home.openMenu.value = true;
                  setMenuOpenCookie(true);
                }
              },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: largerThanIDK
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.center,
            children: [
              Text(
                "Bryan Cancel",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                //bigger part, and smaller part of smaller part
                style: nameStyle,
              ),
              Ternary(
                condition: largerThanIDK,
                isTrue: Visibility(
                  visible: Home.openMenu != null,
                  child: Home.openMenu != null
                      ? AnimatedBuilder(
                          animation: Home.openMenu,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "'s Resume",
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: MyApp.h4,
                                  letterSpacing: 2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 4.0,
                                ),
                                child: Icon(
                                  Icons.arrow_left,
                                ),
                              ),
                            ],
                          ),
                          builder: (BuildContext context, Widget child) {
                            return AnimatedOpacity(
                              duration: Home.startUpComplete.value
                                  ? kTabScrollDuration
                                  : Duration.zero,
                              opacity: Home.openMenu.value == false ? 1 : 0,
                              child: child,
                            );
                          },
                        )
                      : Container(),
                ),
                isFalse: Visibility(
                  visible: Home.openMenu != null,
                  child: Home.openMenu != null
                      ? AnimatedBuilder(
                          animation: Home.openMenu,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 4.0,
                            ),
                            child: Icon(
                              Icons.arrow_left,
                            ),
                          ),
                          builder: (BuildContext context, Widget child) {
                            return AnimatedOpacity(
                              duration: Home.startUpComplete.value
                                  ? kTabScrollDuration
                                  : Duration.zero,
                              opacity: Home.openMenu.value == false ? 1 : 0,
                              child: child,
                            );
                          },
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
