//flutter
import 'package:flutter/material.dart';

//plugins
import 'package:bot_toast/bot_toast.dart';

//internal
import 'package:portfolio/home.dart';
import 'package:portfolio/qrCode.dart';
import 'package:universal_html/html.dart';
import 'dart:ui' as ui;

//GiphyClient client;

closeMenu(var event) {
  Home.openMenu.value = false;
}

void main() {
  // ignore: ERROR undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(
    'iframeElement',
    (int viewId) {
      final wrapper = DivElement()
        ..style.width = '100%'
        ..style.height = '100%';

      final IFrameElement _iframeElement = IFrameElement()
        ..contentEditable = 'true'
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = 'https://b-cancel.github.io/websites/'
        ..style.border = 'none';

      //if they scroll without closing it
      //they might think thats how the website should work
      //which would be worse than them not knowing how to open the resume again immediately
      //surely a white button on the top right with the menu icon should be obvious enough
      _iframeElement.onScroll.capture((event) => closeMenu(event));
      _iframeElement.onMouseWheel.capture((event) => closeMenu(event));
      _iframeElement.onWheel.capture((event) => closeMenu(event));

      //in all the cases below
      //they have already screwed up and tapped or clicked when I wanted them to close with the close button
      //there isn't much I can do about that except TRY to catch that intent
      //and then have them deal with the fact that they may have opened up a gif

      //TODO: read event and trigger a click to close the pop up that MAY have come up

      //on desktop what MIGHT be a click
      _iframeElement.onClick.capture((event) => closeMenu(event));
      _iframeElement.onDoubleClick.capture((event) => closeMenu(event));
      _iframeElement.onMouseDown.capture((event) => closeMenu(event));
      _iframeElement.onMouseUp.capture((event) => closeMenu(event));

      //on mobile what MIGHT be a click
      _iframeElement.onTouchStart.capture((event) => closeMenu(event));
      _iframeElement.onTouchEnd.capture((event) => closeMenu(event));

      //odd return
      wrapper.append(_iframeElement);
      return wrapper;
    },
  );

  //start app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //headers
  static const double h1 = 32;
  static const double h2 = 28;
  static const double h3 = 24;
  //6 units of differenc between stuff that
  //should be as header and stuff that shouldn't
  static const double h4 = 18;
  static const double h5 = 14;
  //tiny shoudn't be any tinier that 12 pt
  static const double h6 = 12;

  static double buttonSize = 56;
  static double smallButtonSize = 48;
  static double smallestButtonSize = 36;

  static ThemeData themeWithModifications({@required bool isDark}) {
    if (isDark) {
      return ThemeData.dark().copyWith(
        //text selection
        textSelectionColor: Colors.blue,
        textSelectionHandleColor: Colors.blue,
        //light mode default
        //brightness: Brightness.light,
        //none of that ugly green
        //primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    } else {
      return ThemeData.light().copyWith(
        //text selection
        textSelectionColor: Colors.blue,
        textSelectionHandleColor: Colors.blue,
        //light mode default
        //brightness: Brightness.light,
        //none of that ugly green
        //primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        title: 'Bryan Cancel\'s Portfolio',
        theme: themeWithModifications(
          isDark: false,
        ),
        home: Home(),
      ),
    );
  }
}
