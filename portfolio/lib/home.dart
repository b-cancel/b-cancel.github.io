//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:portfolio/menu.dart';
import 'package:portfolio/myWork.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universal_html/html.dart';

//internal: other
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
    return Stack(
      children: <Widget>[
        Theme(
          data: ThemeData.dark(),
          child: Scaffold(
            appBar: AppBar(
              title: MyName(),
              actions: <Widget>[
                MenuOpener(
                  openMenu: openMenu,
                ),
              ],
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
    );
  }
}

class MyName extends StatelessWidget {
  const MyName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Bryan Cancel",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MyApp.h3,
        letterSpacing: 4,
      ),
    );
  }
}
