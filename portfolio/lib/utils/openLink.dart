//dart
import 'dart:html' as html; //web only

//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:url_launcher/url_launcher.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';
import 'package:portfolio/utils/mySnackBar.dart';

//opens in this window
openHere(BuildContext context, String url){
  //html is only for web
  if(isWeb()){
    html.window.location.href = url;
    //alt: html.window.location.assign(url);
  }
  else{
    openInNewTab(context, url);
  }
}

//open in another window
openInNewTab(BuildContext context, String url) async {
  try {
    await launch(url);
  } catch(e) {
    showSnackBar(context, text: "LAUNCH failed");
  }

  //Alternatives-------------------------
  //1. only for web
  //html.window.open(url, "linkName");
  //2. for both
  /*
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showSnackBar(context, text: "CAN LAUNCH failed");
  }
  */
}