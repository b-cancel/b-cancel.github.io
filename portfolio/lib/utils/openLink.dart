//dart
//TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
//import 'dart:html' as html; //web only

//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:url_launcher/url_launcher.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';

//opens in this window
openLinkHere(BuildContext context, String url) {
  if (isWeb()) {
    //NOTE: anything using HTML only work on web
    try {
      //try to use function first
      //TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
      //html.window.location.assign(url);
    } catch (e) {
      try {
        //flat our just set the variable
        //TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
        //html.window.location.href = url;
      } catch (e) {
        //try other methods
        openInNewTab(context, url);
      }
    }
  } else {
    //you can't open a link in the app if you are not a web browser
    //NOTE: maybe if you use webviews but I'm not going to use them
    openInNewTab(context, url);
  }
}

//open in another window
openInNewTab(BuildContext context, String url) async {
  //try to properly check if we can launch first
  if (await canLaunch(url)) {
    _launchLink(context, url);
  } else {
    //don't check if it can launch just do it
    _launchLink(context, url);
  }
}

//launch it with url launcher in try catch
_launchLink(BuildContext context, String url) async {
  try {
    await launch(url);
  } catch (e) {
    if(isWeb()){
      //NOTE: anything using HTML only work on web
      try{ 
        //TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
        //html.window.open(url, '');
      }
      catch (e) { 
        copyLinkToClipboard(context, url);
      }
    }
    copyLinkToClipboard(context, url);
  }
}

//if all the launching methods failed 
//atleast try to copy the link to the clipboard
//and notify the user
copyLinkToClipboard(BuildContext context, String url) {

}