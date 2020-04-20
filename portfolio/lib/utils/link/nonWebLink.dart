//plugin
import 'package:flutter/cupertino.dart';
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:url_launcher/url_launcher.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';

//functions
Future<bool> _callNumber(String number)async{
  number = "tel:" + number;
  return await _openNonWebUrl(number);
}

Future<bool> _textNumber(String number)async{
  number = "sms:" + number;
  return await _openNonWebUrl(number);
}

Future<bool> _sendEmail(
  String email, {
    String subject: "", 
    String body: "",
  })async{
  String url = "mailto:";
  url += email;
  url += "?subject=";
  url += Uri.encodeFull(subject);
  url += "&body=";
  url += Uri.encodeFull(body);
  return await _openNonWebUrl(url);
}

Future<bool> _openNonWebUrl(url)async{
  //try to properly check if we can launch first
  if (await canLaunch(url)) {
    return await _actualOpenNonWebUrl(url);
  } else {
    //don't check if it can launch just do it
    return await _actualOpenNonWebUrl(url);
  }
}

Future<bool> _actualOpenNonWebUrl(url)async{
  try{
    return await launch(
      url,
      //---must be set to false since not Web URL
      //*only for Android
      forceWebView: false,
      enableJavaScript: false,
      enableDomStorage: false,
      //headers: new Map<String,String>(),
      //*only for iOS
      forceSafariVC: false,
      universalLinksOnly: false,
      //---settings
      //statusBarBrightness: Brightness.dark,
    );
  } catch (e) {
    try {
      return await launch(
        url,
      );
    } catch (e) {
      return false;
    }
  }
}

//-------------------------Uses Of The Above-------------------------

Future<bool> downloadFile(String file)async{
  //flutter web build will automatically 
  //place things into another assets folder
  if(isWeb()){
    file = "assets/" + file;
  }

  //launch it to download it
  //NOTE: no alternative
  return await _openNonWebUrl(file);
}

//-------------------------Call Text Email-------------------------

callNumber(BuildContext context, String url){
  _callTextOrEmail(
    context, 
    url, 
    IntentType.Call,
  );
}

textNumber(BuildContext context, String url){
  _callTextOrEmail(
    context, 
    url, 
    IntentType.Text,
  );
}

sendEmail(BuildContext context, String url){
  _callTextOrEmail(
    context, 
    url, 
    IntentType.Email,
  );
}

//no download and no open
_callTextOrEmail(BuildContext context, String url, IntentType intentType)async{
  try{  
    bool launchSuccessfull;
    //tries to open non web url successfully
    if(intentType == IntentType.Call){
      launchSuccessfull = await _callNumber(url);
    }
    else if(intentType == IntentType.Text){
      launchSuccessfull = await _textNumber(url);
    }
    else{ //email
      launchSuccessfull = await _sendEmail(url);
    }

    //try the alternative
    if(launchSuccessfull){
      //this works on the principle that
      //if it works, they wont see this

      //NOTE: but it doesn't because the duration 
      //doesn't play when the app is in the background
      
      /*showSnackBar(
        context,
        text: "Something Went Wrong :(",
        duration: Duration(seconds: 2),
      );*/
    }
    else{
      _copyAfterLaunchFailed(context, url, intentType);
    }
  } catch (e) {
    _copyAfterLaunchFailed(context, url, intentType);
  }
}

_copyAfterLaunchFailed(BuildContext context, String url, IntentType intentType){
  copyToClipboard(
    context, 
    url,
    initialIntent: intentType,
  );
}