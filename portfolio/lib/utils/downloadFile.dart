import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'platformChecker.dart';

Future<bool> downloadVCard(location)async{
  //flutter build web stick everything in another assets folder
  if(isWeb()){
    location = "assets/" + location;
  }

  //launch that download
  return await launch(
    location,
    forceSafariVC: false, //what does this do?
    //universalLinksOnly: ?,
    forceWebView: false, //waht does this do?
    statusBarBrightness: Brightness.dark,
  );
}