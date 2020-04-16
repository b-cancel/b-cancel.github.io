//dart
//TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
//import 'dart:html' as html; //web only

//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:url_launcher/url_launcher.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';
import 'package:portfolio/utils/copyToClipboard.dart';
import 'package:portfolio/utils/mySnackBar.dart';

//falls back with url launcher
openWithHtml(BuildContext context, String url, {bool openHere}) {
  if (isNotMobile()) {
    //NOTE: anything using HTML only works on web
    if (openHere) {
      try {
        //try to use function first
        //TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
        //html.window.location.assign(url);
      } catch (e) {
        try {
          //flat out just set the variable
          //TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
          //html.window.location.href = url;
        } catch (e) {
          //try other methods
          openWithUrlLauncher(context, url, openHere: openHere);
        }
      }
    } else {
      //NOTE: anything using HTML only work on web
      try {
        //TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
        //html.window.open(url, '');
      } catch (e) {
        //try other methods
        openWithUrlLauncher(context, url, openHere: openHere);
      }
    }
  } else {
    //you aren't on web you, you can't use HTML
    openWithUrlLauncher(context, url, openHere: openHere);
  }
}

//usually open in another window
openWithUrlLauncher(BuildContext context, String url, {bool openHere}) async {
  //try to properly check if we can launch first
  if (await canLaunch(url)) {
    _launchLink(context, url, openHere: openHere);
  } else {
    //don't check if it can launch just do it
    _launchLink(context, url, openHere: openHere);
  }
}

//launch it with url launcher in try catch
_launchLink(BuildContext context, String url, {bool openHere}) async {
  print("platform checking");
  bool isWeeb = isWeb();
  print("is weeb ");
  print("is weeb " + isWeeb.toString());
  if (isWeeb) {
    print("Web");
    _launchRawLink(context, url);
  }
  else{
    if(isAndroid()){
      try{
        print("android");
        await launch(
          url,
          forceWebView: openHere,
          //set to true, cuz why not
          enableJavaScript: true,
          enableDomStorage: true,
          //headers: new Map<String,String>(),
        );
      } catch (e) {
        _launchRawLink(context, url);
      }
    }
    else if(isiOS()){
      try{
        print("ios");
        await launch(
          url,
          forceSafariVC: openHere,
          //if we don't want it to openHere
          //then we can mess with universalLinksOnly
          universalLinksOnly: false, //no open the link even if not universal
        );
      } catch (e) {
        _launchRawLink(context, url);
      }
    }
    else{
      print("other");
      _launchRawLink(context, url);
    }
  }
}

_launchRawLink(BuildContext context, String url) async {
  print("web or first one failed");
  try {
    await launch(
      url,
    );
  } catch (e) {
    print("Error so coppying to clipboard");
    copyLinkToClipboard(context, url);
  }
}

//if all the launching methods failed
//atleast try to copy the link to the clipboard
//and notify the user
copyLinkToClipboard(BuildContext context, String url) async {
  //try to copy the link to the clipboard
  //depending on whether or not it fails show a pop up
  String basicMessage = "Unable To Open \"" + url + "\"";
  if (await copyToClipboard(url)) {
    showSnackBar(
      context,
      text: basicMessage + "\nBut it was copied to your clipboard",
      duration: Duration(seconds: 7),
    );
  } else {
    showSnackBar(
      context,
      text: basicMessage + "\nBut you can copy it from here",
      duration: Duration(minutes: 1),
    );
  }
}
