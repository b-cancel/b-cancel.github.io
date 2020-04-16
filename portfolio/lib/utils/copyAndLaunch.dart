import 'dart:io';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:url_launcher/url_launcher.dart';

isMobile(){
  return Platform.isAndroid || Platform.isIOS;
}

copyItem(
  BuildContext context,
  IconData icon, {
  String item,
  String message,
}) async {
  //clipboards only working for android and iOS
  if(isMobile()){
    FlutterClipboardManager.copyToClipBoard(item).then(
    (result) {
      print("idk");
      if (result) {
        print("yes");
        showSnackBar(
          context,
          text: item + " Copied To Clipboard",
          duration: Duration(minutes: 1),
          icon: Icons.content_copy,
        );
      } else {
        print("no");
        showSnackBar(
          context,
          text: message,
          duration: Duration(minutes: 1),
          icon: Icons.phone,
        );
      }
    },
  );
  }
  else{
    //clippy
  }
}

launchItem(String url, String message) async{
  //attempt to launch
  try {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } catch (e) {
    
  }
}

launchLink(BuildContext context, int method)async{
  String url = "https://www.google.com";
  switch(method){
    case 0: 
      html.window.open(url, "linkName");
      break;
    case 1:
      html.window.location.href = url;
      break;
    case 2:
      html.window.location.assign(url);
      break;
    case 3:
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        showSnackBar(context, text: "CAN LAUNCH failed");
      }
      break;
    case 4:
      try {
        await launch(url);
      } catch(e) {
        showSnackBar(context, text: "LAUNCH failed");
      }
      break;
    default: //case 5 is last case
      html.window.open(url, "");
      break;
  }
}