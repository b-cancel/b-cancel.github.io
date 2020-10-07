//flutter
import 'package:flutter/material.dart';

//plugins
import 'package:bot_toast/bot_toast.dart';
//import 'package:giphy_client/giphy_client.dart';

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

      //workaround
      _iframeElement.onMouseOver.capture((element) => closeMenu(element));

      //both
      _iframeElement.onScroll.capture((event) => closeMenu(event));

      //close menu [desktop]
      _iframeElement.onMouseWheel.capture((event) => closeMenu(event));
      _iframeElement.onWheel.capture((event) => closeMenu(event));

      _iframeElement.onClick.capture((event) => closeMenu(event));
      _iframeElement.onDoubleClick.capture((event) => closeMenu(event));

      //NOTE: on up since we can move mouse and "cancel" action
      //_iframeElement.onMouseDown.capture((event) {});
      _iframeElement.onMouseUp.capture((event) => closeMenu(event));
      //_iframeElement.onMouseOver.any((element) => closeMenu);

      //close menu [mobile]
      //_iframeElement.onTouchStart.capture((event) {});
      //_iframeElement.onTouchEnter.capture((event) {});
      //_iframeElement.onTouchMove.capture((event) {});
      //_iframeElement.onTouchLeave.capture((event) {});

      //_iframeElement.onTouchCancel.capture((event) {});
      _iframeElement.onTouchEnd.capture((event) => closeMenu(event));

      /*
    //these below should only relate to dragging and dropping
    _iframeElement.onDragEnd.capture((event) {});

    _iframeElement.onDragEnter.capture((event) {});
    _iframeElement.onDragLeave.capture((event) {});
    _iframeElement.onDragOver.capture((event) {});
    _iframeElement.onDragStart.capture((event) {});
    */

      wrapper.append(_iframeElement);
      return wrapper;
    },
  );

  /*
    ui.platformViewRegistry.registerViewFactory('someViewType', (int viewId) {
    final wrapper = DivElement()
      ..style.width = '100%'
      ..style.height = '100%';
    
    final div = DivElement()
      ..contentEditable = 'true'
      ..style.width = '100%'
      ..style.color = "red"
      ..style.backgroundColor = 'red'
      ..style.height = '100%';
    wrapper.append(div);
    return wrapper;
  });
  */

  //giphy setup
  /*
  client = new GiphyClient(
    //apiKey: 'YMQVelhTCeQcE0ShiI1j9bz4q5fWzxKQ',
    apiKey: 'f6y8PDyNvi7WblWG76jS3V1Z9h2viokr',
  );
  */

  //start app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //the QR Codes used throughout
  //used like this to avoid regeneration
  static Widget qrCodeWhiteWillExpand = AdjustableQrCode(
    squaresColor: Colors.white,
  );
  static Widget qrCodeBlackWillExpand = AdjustableQrCode(
    squaresColor: Colors.black,
  );

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
        theme: ThemeData.light().copyWith(
          //text selection
          textSelectionColor: Colors.blue,
          textSelectionHandleColor: Colors.blue,
          //light mode default
          brightness: Brightness.light,
          //none of that ugly green
          //primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}
