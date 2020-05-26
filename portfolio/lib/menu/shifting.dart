//flutter
import 'package:flutter/material.dart';

//internal
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/utils/link/ui/iconLink.dart';
import 'package:portfolio/menu/titleShuffle.dart';
import 'package:portfolio/data.dart';
import 'package:portfolio/home.dart';

//main menu widget
class ShiftingMenu extends StatelessWidget {
  const ShiftingMenu({
    Key key,
    @required this.minWidth,
    @required this.maxWidth,
    @required this.openMenu,
  }) : super(key: key);

  final double minWidth;
  final double maxWidth;
  final ValueNotifier<bool> openMenu;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
        ),
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
                Expanded(
                  child: SingleChildScrollView(
                    //When this is true, the scroll view is scrollable
                    //even if it does not have sufficient content to actually scroll
                    primary: true,
                    //iOS feel
                    physics: BouncingScrollPhysics(),
                    //atleast spacing to match name
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    //children
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Logo(
                          lightMode: true,
                        ),
                        Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.spaceBetween,
                          runSpacing: 8,
                          spacing: 16,
                          children: <Widget>[
                            IconWebLink(
                              url: myGithub,
                              icon: IconLinkIcon(
                                icon: PortfolioIcons.github,
                              ),
                              label: "Github",
                            ),
                            IconWebLink(
                              url: myLinkedIn,
                              icon: IconLinkIcon(
                                icon: PortfolioIcons.linkedin,
                              ),
                              label: "Linked In",
                            ),
                            IconPhoneLink(
                              icon: IconLinkIcon(
                                icon: PortfolioIcons.phone,
                              ),
                              url: myNumber,
                              label: myNumber,
                            ),
                            IconEmailLink(
                              icon: IconLinkIcon(
                                icon: PortfolioIcons.email,
                              ),
                              url: myEmail,
                              label: myEmail,
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.red,
                          child: Text("hello"),
                        ),
                        Container(
                          color: Colors.red,
                          child: Text(
                            "text",
                          ),
                        ),
                        Container(
                          color: Colors.blue,
                          child: Text(
                            "text",
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          child: Text(
                            "text",
                          ),
                        ),
                        Container(
                          child: Text(
                            "text",
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          child: Text("hello"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}