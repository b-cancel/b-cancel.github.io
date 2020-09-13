//flutter
import 'package:flutter/material.dart';

//plugins
import 'package:bot_toast/bot_toast.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:portfolio/demos/listDemo.dart';

//internal
import 'package:portfolio/home.dart';
import 'package:portfolio/qrCode.dart';

GiphyClient client;

void main() => runApp(ListDemo());

//other
/*
void main() {
  //giphy setup
  client = new GiphyClient(
    apiKey: 'YMQVelhTCeQcE0ShiI1j9bz4q5fWzxKQ',
  );

  //start app
  runApp(MyApp());
}
*/

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
