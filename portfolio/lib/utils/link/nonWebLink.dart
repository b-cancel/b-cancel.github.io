//plugin
import 'package:portfolio/utils/link/copyToClipboard.dart';
import 'package:url_launcher/url_launcher.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';

//functions
Future<bool> _openNonWebUrl(url, IntentType intent)async{
  //TODO: intent to alternative action
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
  return await _openNonWebUrl(file, IntentType.Download);
}

Future<bool> callNumber(String number)async{
  number = "tel:" + number;
  return await _openNonWebUrl(number, IntentType.Call); 
}

Future<bool> textNumber(String number)async{
  number = "sms:" + number;
  return await _openNonWebUrl(number, IntentType.Text);
}

Future<bool> sendEmail(
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
  return await _openNonWebUrl(url, IntentType.Email);
}