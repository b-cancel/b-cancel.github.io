//flutter
import 'package:flutter/material.dart';

//plugin
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
    return Text(
      "Bryan Cancel",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      //bigger part, and smaller part of smaller part
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MyApp.h2,
        letterSpacing: 2,
      ),
    );
  }
}
