//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/utils/conditional.dart';

//plugin
import 'package:universal_html/html.dart';

//internal: other
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

//widgets
class Home extends StatelessWidget {
  static double appBarSize;

  //the menu MUST start off open
  static final ValueNotifier<bool> openMenu = new ValueNotifier<bool>(
    true,
  );

  static final ValueNotifier<bool> startUpComplete = new ValueNotifier(
    false,
  );

  static toggleMenu() {
    if (Home.openMenu != null) {
      if (Home.openMenu.value == false) {
        Home.openMenu.value = true;
      } else {
        Home.openMenu.value = false;
      }
    }
  }

  //build
  @override
  Widget build(BuildContext context) {
    //varies depending on device size
    appBarSize = AppBar().preferredSize.height;

    return Scaffold(
      backgroundColor: Color(0xFF303030),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Theme(
                data: MyApp.themeWithModifications(
                  isDark: true,
                ),
                child: GalleryInBody(),
              ),
            ),
            Positioned.fill(
              child: Theme(
                data: MyApp.themeWithModifications(
                  isDark: false,
                ),
                child: ResumeInMenu(
                  menuKey: menuKey,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: SizedBox(
                height: appBarSize,
                width: appBarSize,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: AnimatedIconButton(),
                ),
              ),
            ),
            FadeAfterLoaded(
              startUpComplete: startUpComplete,
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedIconButton extends StatefulWidget {
  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  AnimationController animation;

  menuStateChanged() {
    if (Home.openMenu.value) {
      animation.forward();
    } else {
      animation.reverse();
    }
  }

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: kTabScrollDuration,
    );
    Home.openMenu.addListener(menuStateChanged);
  }

  @override
  void dispose() {
    animation.dispose();
    Home.openMenu.removeListener(menuStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: ClipOval(
        child: Material(
          color: Colors.white,
          child: IconButton(
            color: Colors.black,
            icon: AnimatedIcon(
              //menus always start off closed
              //so the menu button should show
              icon: AnimatedIcons.menu_close,
              progress: animation,
            ),
            onPressed: () {
              Home.toggleMenu();
            },
          ),
        ),
      ),
    );
  }
}

class FadeAfterLoaded extends StatelessWidget {
  const FadeAfterLoaded({
    Key key,
    @required this.startUpComplete,
  }) : super(key: key);

  final ValueNotifier<bool> startUpComplete;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: AnimatedBuilder(
        animation: startUpComplete,
        builder: (context, child) {
          return AnimatedContainer(
            duration: kTabScrollDuration,
            color:
                startUpComplete.value ? Colors.transparent : Color(0xFF030303),
          );
        },
      ),
    );
  }
}

class GalleryInBody extends StatelessWidget {
  const GalleryInBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          titleSpacing: 0,
          title: MyName(
            inMenu: false,
          ),
          actions: [
            //spacer so button on top causes name to overflow as expected
            Container(
              height: Home.appBarSize,
              width: Home.appBarSize,
              color: Colors.transparent,
            )
          ],
        ),
        Expanded(
          child: IframeSection(),
        ),
      ],
    );
  }
}

//NOTE: must be the same for both appbar and the menu
//so that you get the cool transition effect
class MyName extends StatelessWidget {
  const MyName({
    Key key,
    this.inMenu: true,
  }) : super(key: key);

  final bool inMenu;

  @override
  Widget build(BuildContext context) {
    TextStyle nameStyle = TextStyle(
      inherit: false,
      color: inMenu ? Colors.black : Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: MyApp.h2,
      letterSpacing: 2,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Text(
        "Bryan Cancel",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        //bigger part, and smaller part of smaller part
        style: nameStyle,
      ),
    );
  }
}
