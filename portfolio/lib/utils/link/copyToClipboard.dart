//plugins
import 'package:clippy/browser.dart' as clippy;
import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:portfolio/utils/mySnackBar.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';

//enum handling
enum IntentType {Open, Call, Message, Email, Download} //NOT Copy
intentTypeToString(IntentType intentType){
  if(intentType == IntentType.Open){
    return "Open";
  }
  if(intentType == IntentType.Open){
    return "Call";
  }
  if(intentType == IntentType.Open){
    return "Message";
  }
  if(intentType == IntentType.Open){
    return "Email";
  }
  if(intentType == IntentType.Open){
    return "Download";
  }
  else{
    return null;
  }
}

//function
copyToClipboard(BuildContext context, String url, {
  //we may have want to open the link but it failed
  //so communicate that we copied as an alternative
  IntentType initialIntent,
  //DONT hide a failure
  //its even worse if what you originally designed is trash
  String alternativeMessage,
})async{
  //prep string
  String intentTypeString = intentTypeToString(initialIntent) ?? "";
  String intent = "Unable To " + intentTypeString + " \"" + url + "\"";

  //process
  if(await _copyToClipboard(url)){
    if(initialIntent == null){ //originally wanted to copy
      showSnackBar(
        context,
        text: "\"" + url + "\" Copied To Clipboard",
        icon: Icons.content_copy,
      );
    }
    else{ //copying is something else
      showSnackBar(
        context,
        text: intent + "\n" + "But it was copied to your clipboard",
        icon: Icons.content_copy,
      );
    }
  }
  else{
    String copyError = "Unable To Copy \"" + url + "\"";

    //they dont need to know you failed twice *cries*
    //dont mention anything about copying
    String failureMessage = (initialIntent != null) ? intent : copyError;
    //new line to secondary messages if they exist
    String secondaryMessage = alternativeMessage ?? "";
    if(secondaryMessage.length > 0){
      secondaryMessage = "\n" + secondaryMessage;
    }

    //show alternative message if needed
    showSnackBar(
      context,
      text: failureMessage + secondaryMessage,
    );
  }
}

//report back if it failed
Future<bool> _copyToClipboard(String string)async{
  if(isWeb()){
    try{
      //will always return null
      await _copyWithClippy(string);
      return true;
    } catch (e) {
      return false;
    }
  }
  else{
    bool firstAttemptSuccess = await _copyWithFlutterClipboardManager(string);
    if(firstAttemptSuccess){
      return true;
    }
    else{
      return await _copyWithClipboardManager(string);
    }
  }
}

//should only work for desktop 
//confirmed not working on Android, presumed not working on iOS
//worked on windows (but returned null with type NULL instead of true)
Future<bool> _copyWithClippy(String string)async{
  try{
    return await clippy.write(string);
  } catch (e) {
    return false;
  }
}

//should only work for mobile
//confirmed working on Android, presumed workin on iOS
//did not work on windows, presume only mobile as indicated
Future<bool> _copyWithClipboardManager(String string)async{
  try {
    return await ClipboardManager.copyToClipBoard(string);
  } catch (e) {
    return false;
  }
}

//MIGHT work with both (unknwon untested)
//confirmed working on Android, presumed workin on iOS
//did not work on windows, presume only mobile
Future<bool> _copyWithFlutterClipboardManager(String string)async{
  try {
    return await FlutterClipboardManager.copyToClipBoard(string);
  } catch (e) {
    return false;
  }
}