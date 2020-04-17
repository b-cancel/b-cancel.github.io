//plugins
import 'package:clippy/browser.dart' as clippy;
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

//internal
import 'package:portfolio/utils/platformChecker.dart';

//report back if it failed
Future<bool> copyToClipboard(String string)async{
  if(isWeb()){
    try{
      //will always return null
      print("before start clippy");
      await copyWithClippy(string);
      print("After end clippy");
      return true;
    } catch (e) {
      return false;
    }
  }
  else{
    bool firstAttemptSuccess = await copyWithFlutterClipboardManager(string);
    if(firstAttemptSuccess){
      return true;
    }
    else{
      return await copyWithClipboardManager(string);
    }
  }
}

//should only work for desktop 
//confirmed not working on Android, presumed not working on iOS
//worked on windows (but returned null with type NULL instead of true)
Future<bool> copyWithClippy(String string)async{
  try{
    return await clippy.write(string);
  } catch (e) {
    return false;
  }
}

//should only work for mobile
//confirmed working on Android, presumed workin on iOS
//did not work on windows, presume only mobile as indicated
Future<bool> copyWithClipboardManager(String string)async{
  try {
    return await ClipboardManager.copyToClipBoard(string);
  } catch (e) {
    return false;
  }
}

//MIGHT work with both (unknwon untested)
//confirmed working on Android, presumed workin on iOS
//did not work on windows, presume only mobile
Future<bool> copyWithFlutterClipboardManager(String string)async{
  try {
    return await FlutterClipboardManager.copyToClipBoard(string);
  } catch (e) {
    return false;
  }
}