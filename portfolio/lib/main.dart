//flutter
import 'package:flutter/material.dart';
import 'package:portfolio/home.dart';

//plugins
import 'package:portfolio/icons/portfolio_icons_icons.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:portfolio/qrCode.dart';
import 'package:portfolio/utils/wrappedText.dart';

//internal

//other
void main() {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [BotToastNavigatorObserver()],
        title: 'Bryan\'s Portfolio',
        theme: ThemeData(
          //text selection
          textSelectionColor: Colors.blue,
          textSelectionHandleColor: Colors.blue,
          //light mode default
          brightness: Brightness.light,
          //none of that ugly green
          primarySwatch: Colors.blue,
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
