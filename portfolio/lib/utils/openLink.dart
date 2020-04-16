//dart
//TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
//import 'dart:html' as html; //web only

//flutter
import 'package:flutter/material.dart';

//plugin
import 'package:url_launcher/url_launcher.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';

import 'copyToClipboard.dart';
import 'mySnackBar.dart';
import 'mySnackBar.dart';

//falls back with url launcher
openWithHtml(BuildContext context, String url, {bool openHere}) {
  if (isWeb()) {
    //NOTE: anything using HTML only works on web
    if(openHere){
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
    }
    else{
      //NOTE: anything using HTML only work on web
      try{ 
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
  try {
    /*
    [forceSafariVC] is only used in iOS with iOS version >= 9.0. 
    By default (when unset), the launcher opens web URLs in the Safari View Controller, 
    anything else is opened using the default handler on the platform. If set to true, 
    it opens the URL in the Safari View Controller. 
    If false, the URL is opened in the default browser of the phone. 
    Note that to work with universal links on iOS, this must be set to false to let the platform's system handle the URL. 
    Set this to false if you want to use the cookies/context of the main browser of the app (such as SSO flows). 
    This setting will nullify [universalLinksOnly] and will always launch a web content in the 
    built-in Safari View Controller regardless if the url is a universal link or not.

    [universalLinksOnly] is only used in iOS with iOS version >= 10.0. 
    This setting is only validated when [forceSafariVC] is set to false. 
    The default value of this setting is false. By default (when unset), 
    the launcher will either launch the url in a browser (when the url is not a universal link), 
    or launch the respective native app content (when the url is a universal link). 
    When set to true, the launcher will only launch the content if the url is a 
    universal link and the respective app for the universal link is installed on 
    the user's device; otherwise throw a [PlatformException].

    [forceWebView] is an Android only setting. If null or false, 
    the URL is always launched with the default browser on device. 
    If set to true, the URL is launched in a WebView. Unlike iOS, 
    browser context is shared across WebViews. [enableJavaScript] 
    is an Android only setting. If true, WebView enable javascript. 
    
    [enableDomStorage] is an Android only setting. 
    If true, WebView enable DOM storage. 
    
    [headers] is an Android only setting that adds headers to the WebView.

    Note that if any of the above are set to true but the URL is not a web URL, this will throw a [PlatformException].

    [statusBarBrightness] Sets the status bar brightness of the application after opening a link on iOS. 
    Does nothing if no value is passed. This does not handle resetting the previous status bar style.

    Returns true if launch url is successful; false is only returned when [universalLinksOnly] 
    is set to true and the universal link failed to launch.
    */
    await launch(
      url,
      statusBarBrightness: Brightness.dark,
    );
  } catch (e) {
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
  if(await copyToClipboard(url)){
    showSnackBar(
      context,
      text: basicMessage
      + "\nBut it was copied to your clipboard",
      duration: Duration(seconds: 7),
    );
  } else {
    showSnackBar(
      context,
      text: basicMessage
      + "\nBut you can copy it from here",
      duration: Duration(minutes: 1),
    );
  }
}