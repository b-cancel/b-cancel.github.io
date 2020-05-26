//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/titleShuffle.dart';
import 'package:portfolio/utils/goldenRatio.dart';
import 'package:portfolio/home.dart';

//only allows opening once the menu is fully closed
//but fades in and out as intent is communicated
class MenuOpener extends StatelessWidget {
  const MenuOpener({
    Key key,
    @required this.openMenu,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: openMenu,
      child: IconButton(
        icon: Icon(
          PortfolioIcons.file_alt,
        ),
        onPressed: () {
          if (openMenu.value == false) {
            openMenu.value = true;
          }
        },
      ),
      builder: (context, child) {
        return AnimatedOpacity(
          opacity: openMenu.value ? 0 : 1,
          duration: kTabScrollDuration,
          child: child,
        );
      },
    );
  }
}

//widget
class ResumeInMenu extends StatelessWidget {
  const ResumeInMenu({
    Key key,
    @required this.menuKey,
    @required this.openMenu,
  }) : super(key: key);

  final GlobalKey menuKey;
  final ValueNotifier<bool> openMenu;

  //build
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print("Screen width: " + screenWidth.toString());

    //anything bigger and users won't be able to see
    //or click on the my work section
    double minWidth = toGoldenRatioSmall(
      screenWidth,
    );

    //compromise golden ratio when small for cool transition effect
    double maxWidth = screenWidth - 56;

    //build
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: AnimatedBuilder(
        animation: openMenu,
        builder: (context, child) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: AnimatedContainer(
                    duration: kTabScrollDuration,
                    color: openMenu.value
                        ? Colors.black.withOpacity(.5)
                        : Colors.transparent,
                    child: MenuCloser(
                      openMenu: openMenu,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    AnimatedContainer(
                      height: MediaQuery.of(context).size.height,
                      duration: kTabScrollDuration,
                      transform: Matrix4.translationValues(
                        (openMenu.value) ? 0 : -getMenuWidth(),
                        0,
                        0,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: minWidth,
                          maxWidth: maxWidth,
                        ),
                        child: Material(
                          child: Container(
                            key: menuKey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  AnimatedContainer(
                                    duration: kTabScrollDuration,
                                    transform: Matrix4.translationValues(
                                      (openMenu.value) ? 0 : getMenuWidth(),
                                      0,
                                      0,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: MyName(),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Logo(
                                      lightMode: true,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox.shrink(
                                          child: Container(
                                            color: Colors.red,
                                            child: Text(
                                              "text",
                                            ),
                                          ),
                                        ),
                                        SizedBox.shrink(
                                          child: Container(
                                            color: Colors.blue,
                                            child: Text(
                                              "text",
                                            ),
                                          ),
                                        ),
                                        SizedBox.shrink(
                                          child: Container(
                                            color: Colors.red,
                                            child: Text(
                                              "text",
                                            ),
                                          ),
                                        ),
                                        SizedBox.shrink(
                                          child: Container(
                                            child: Text(
                                              "text",
                                            ),
                                          ),
                                        ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  /*
                                  Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        spacing: 16,
        children: <Widget>[
            IconPhoneLink(
              icon: IconLinkIcon(
                icon: PortfolioIcons.phone,
              ),
              url: number,
              label: number,
            ),
            IconEmailLink(
              icon: IconLinkIcon(
                icon: PortfolioIcons.email,
              ),
              url: email,
              label: email,
            ),
            IconWebLink(
              url: github,
              icon: IconLinkIcon(
                icon: PortfolioIcons.github,
              ),
              label: "Github",
            ),
                                  */

                                  /*
                                  Expanded(
                                    child: ListView(
                                      children: [
                                        /*
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              color: Colors.red,
                                              height: 8,
                                              width: toGoldenRatioBig(320),
                                            ),
                                            Expanded(
                                              child: Container(
                                                color: Colors.blue,
                                                height: 8,
                                              ),
                                            ),
                                          ],
                                        ),
                                        */
                                        
                                        Center(
                                          child: Text("resume and such"),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimatedOpacity(
                        duration: kTabScrollDuration,
                        opacity: openMenu.value ? 1 : 0,
                        child: MenuCloser(
                            openMenu: openMenu,
                            child: DefaultTextStyle(
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: MyApp.h4,
                              ),
                              child: Text(
                                "M\nY\n\nW\nO\nR\nK",
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MenuCloser extends StatelessWidget {
  const MenuCloser({
    Key key,
    @required this.openMenu,
    this.child,
  }) : super(key: key);

  final ValueNotifier<bool> openMenu;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (openMenu.value) {
            openMenu.value = false;
          }
        },
        child: child ?? Container(),
      ),
    );
  }
}
