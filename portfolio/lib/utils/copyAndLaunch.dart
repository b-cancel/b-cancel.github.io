import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:portfolio/utils/platformChecker.dart';
import 'package:url_launcher/url_launcher.dart';

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