//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/data.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';

//plugin
import 'package:dynamic_overflow_menu_bar/dynamic_overflow_menu_bar.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:universal_html/html.dart';

//internal: other
import 'package:portfolio/menu/menu.dart';
import 'package:portfolio/myWork.dart';
import 'package:portfolio/main.dart';

//function used for main page and menu shifting
final GlobalKey menuKey = GlobalKey();
double getMenuWidth() {
  final keyContext = menuKey.currentContext;
  if (keyContext != null) {
    final box = keyContext.findRenderObject() as RenderBox;
    return box.size.width;
  } else {
    return null;
  }
}

//widgets
class Home extends StatelessWidget {
  //TODO: read the web parameter to determine whether we want it initally opened or initially closed
  final ValueNotifier<bool> openMenu = new ValueNotifier<bool>(
    true,
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
                title: DynamicOverflowMenuBar(
                  title: MyName(
                    openMenu: openMenu,
                  ),
                  actions: [
                    //TODO: in all cases tapping the label should copy it
                    //TODO: repair the pop up that isnt showing text for some odd reason
                    //TODO: if the width is larger than 430 -> use action sheet when pressing contact link
                    //TODO: the above is particularly important so the behavior is consitent when things start to wrap
                    OverFlowMenuItem(
                      onPressed: null,
                      label: "Github",
                      child: IconWebLink(
                        url: myGithub,
                        lightMode: false,
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.github,
                          mini: true,
                        ),
                        label: "Github",
                      ),
                    ),
                    OverFlowMenuItem(
                      onPressed: null,
                      label: "Linked In",
                      child: IconWebLink(
                        url: myLinkedIn,
                        lightMode: false,
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.linkedin,
                          mini: true,
                        ),
                        label: "Linked In",
                      ),
                    ),
                    OverFlowMenuItem(
                      onPressed: null,
                      label: myNumber,
                      child: IconPhoneLink(
                        lightMode: false,
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.phone,
                          mini: true,
                        ),
                        url: myNumber,
                        label: myNumber,
                      ),
                    ),
                    OverFlowMenuItem(
                      onPressed: null,
                      label: myEmail,
                      child: IconEmailLink(
                        lightMode: false,
                        icon: IconLinkIcon(
                          icon: PortfolioIcons.email,
                          mini: true,
                        ),
                        url: myEmail,
                        label: myEmail,
                      ),
                    )
                  ],
                ),
              ),
              //NOTE: transition handled internally
              body: MyWork(
                openMenu: openMenu,
              ),
            ),
          ),
          Positioned.fill(
            //NOTE: transition handled internally
            child: ResumeInMenu(
              menuKey: menuKey,
              openMenu: openMenu,
            ),
          ),
        ],
      ),
    );
  }
}

//NOTE: must be the same for both appbar and the menu
//so that you get the cool transition effect
class MyName extends StatelessWidget {
  const MyName({
    Key key,
    this.openMenu,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;

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
        onTap: openMenu == null
            ? null
            : () {
                if (openMenu.value == false) {
                  openMenu.value = true;
                }
              },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Bryan Cancel",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                //bigger part, and smaller part of smaller part
                style: nameStyle,
              ),
              Visibility(
                visible: openMenu != null && largerThanIDK,
                child: openMenu != null
                    ? AnimatedBuilder(
                        animation: openMenu,
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
                            duration: kTabScrollDuration,
                            opacity: openMenu.value == false ? 1 : 0,
                            child: child,
                          );
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
