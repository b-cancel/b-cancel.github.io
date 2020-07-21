//flutter
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/data.dart';
import 'package:portfolio/icons/portfolio_icons_icons.dart';

//plugin
import 'package:dynamic_overflow_menu_bar/dynamic_overflow_menu_bar.dart';
import 'package:portfolio/utils/conditional.dart';
import 'package:portfolio/utils/link/ui/hover.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:universal_html/html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  printString(BuildContext context, String s) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("point detect"),
          content: Text(s),
        );
      },
    );
  }

  OverFlowMenuItem overFlowMenuItem(
    BuildContext context, {
    @required String label,
    @required IconData icon,
    bool isIrregular: false,
  }) {
    return OverFlowMenuItem(
        onPressed: () {
          BotToast.showAttachedWidget(
            attachedBuilder: (_) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
              ),
            ),
          );
        },
        label: label,
        child: OpaqueOnHover(
          invert: false,
          child: Material(
            borderRadius: BorderRadius.circular(56),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                printString(
                  context,
                  "tap: " + PointerOnHover.isActive().toString(),
                );
              },
              onLongPress: () {
                printString(
                  context,
                  "hold: " + PointerOnHover.isActive().toString(),
                );
              },
              child: Ternary(
                condition: isIrregular,
                isTrue: Container(
                  width: 22.0 + 8 * 2,
                  height: 22.0 + 8 * 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 1,
                    ),
                    child: Icon(
                      icon,
                      size: 17,
                    ),
                  ),
                ),
                isFalse: IconLinkIcon(
                  icon: icon,
                  mini: true,
                ),
              ),
            ),
          ),
        )
        /*
          IconWebLink(
            url: myGithub,
            lightMode: false,
            icon: IconLinkIcon(
              icon: PortfolioIcons.github,
              mini: true,
            ),
            label: "Github",
          ),*/
        );
  }

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
                title: Padding(
                  padding: EdgeInsets.only(
                    right: 8,
                  ),
                  child: DynamicOverflowMenuBar(
                    title: MyName(
                      openMenu: openMenu,
                    ),
                    actions: [
                      //NOTE: the item in the front will always be in the front... GITHUB
                      //VCard should show up for downloading
                      //a shortcut to the QR Code should also show up

                      /*
                          openWithHtml(
          context,
          url,
          openHere: true,
        );
      },
      onShowOptions: () {
        showOptions(
          context,
          lightMode: lightMode,
          children: [
            OptionButton(
              label: label,
              addBorder: true,
            ),
            OptionButton(
              icon: PortfolioIcons.open_in_new,
              label: "New Tab",
              onTap: () {
                openWithHtml(
                  context,
                  url,
                  openHere: false,
                );
              },
            ),
            OptionButton(
              icon: PortfolioIcons.content_copy,
              label: "Copy",
              onTap: () {
                copyToClipboard(
                  context,
                  url,
                );
              },
            ),
          ],
        );
                          */

                      //TODO: in all cases tapping the label should copy it
                      //TODO: repair the pop up that isnt showing text for some odd reason
                      //TODO: if the width is larger than 430 -> use action sheet when pressing contact link
                      //TODO: the above is particularly important so the behavior is consitent when things start to wrap

                      //github link (with specific part highlighted) [also copies link]
                      //---
                      //open link (?? icon)***on mobile on tap assume this
                      //open in new tab (tab icon)
                      //copy link (copy icon)
                      overFlowMenuItem(
                        context,
                        label: "Github",
                        icon: PortfolioIcons.github,
                      ),
                      //linked in link (with specific part highlighted) [also copies link]
                      //---
                      //open link (?? icon)***on mobile on tap assume this
                      //open in new tab (tab icon)
                      //copy link (copy icon)
                      overFlowMenuItem(
                        context,
                        label: "Linked In",
                        icon: PortfolioIcons.linkedin,
                      ),
                      //phone number (with specifics highlighted) [also copies number]
                      //---
                      //call number
                      //text number
                      //copy number ***on mobile on tap assume this
                      //---
                      //save V-Card
                      overFlowMenuItem(
                        context,
                        label: myNumber,
                        icon: PortfolioIcons.phone,
                      ),
                      //email (with specifics higlighted) [also copies email]
                      //---
                      //send email
                      //copy email ***on mobile on tap assume this
                      //---
                      //save V-Card
                      overFlowMenuItem(
                        context,
                        label: myEmail,
                        icon: PortfolioIcons.email,
                      ),
                      //TODO: actually get this to do stuff
                      overFlowMenuItem(
                        context,
                        label: "Contact Card",
                        icon: PortfolioIcons.address_card,
                        //icon is irregularly big and improperly centered
                        isIrregular: true,
                      ),
                      //TODO: actually get this to do stuff
                      overFlowMenuItem(
                        context,
                        label: "Scannable Contact Card",
                        icon: FontAwesomeIcons.qrcode, //TODO: optimize
                      ),
                    ],
                  ),
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
