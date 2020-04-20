//dart
import 'package:universal_html/html.dart' as html;

//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:url_launcher/url_launcher.dart';

//internal
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/platformChecker.dart';

//falls back with url launcher
openWithHtml(BuildContext context, String url, {bool openHere}) {
  if (isWeb()) {
    //NOTE: anything using HTML only works on web
    if (openHere) {
      try {
        //try to use function first
        html.window.location.assign(url);
      } catch (e) {
        try {
          //flat out just set the variable
          html.window.location.href = url;
        } catch (e) {
          //try other methods
          openWithUrlLauncher(context, url, openHere: openHere);
        }
      }
    } else {
      //NOTE: anything using HTML only work on web
      try {
        html.window.open(url, '');
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
  if (isWeb()) {
    _launchRawLink(context, url);
  }
  else{
    if(isAndroid()){
      try{
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
    else{ //handle windows, macOS, and linus the same
      _launchRawLink(context, url);
    }
  }
}

_launchRawLink(BuildContext context, String url) async {
  try {
    await launch(
      url,
    );
  } catch (e) {
    copyToClipboard(
      context, 
      url,
      initialIntent: IntentType.Open,
    );
  }
}