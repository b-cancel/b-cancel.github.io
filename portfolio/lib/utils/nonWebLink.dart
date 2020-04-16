//plugin
import 'package:url_launcher/url_launcher.dart';

//internal
import 'platformChecker.dart';

//functions
Future<bool> openNonWebUrl(url)async{
  //try to properly check if we can launch first
  if (await canLaunch(url)) {
    return await actualOpenNonWebUrl(url);
  } else {
    //don't check if it can launch just do it
    return await actualOpenNonWebUrl(url);
  }
}

Future<bool> actualOpenNonWebUrl(url)async{
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
    return false;
  }
}

//-------------------------Uses Of The Above-------------------------

Future<bool> downloadFile(String file)async{
  //flutter web build will automatically 
  //place things into another assets folder
  if(isNotMobile()){
    file = "assets/" + file;
  }

  //launch it to download it
  return await openNonWebUrl(file);
}

Future<bool> dialNumber(String number)async{
  number = "tel:" + number;
  return await openNonWebUrl(number); 
}

Future<bool> messageNumber(String number)async{
  number = "sms:" + number;
  return await openNonWebUrl(number);
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
  return await openNonWebUrl(url);
}