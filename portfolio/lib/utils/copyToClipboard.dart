//TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
import 'package:clippy/browser.dart' as clippy;
import 'package:portfolio/utils/mySnackBar.dart';
import 'package:portfolio/utils/platformChecker.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

//report back if it failed
Future<bool> copyToClipboard(String string)async{
  if(isWeb()){
    
  }
  else{

  }
}

//should only work for desktop 
//confirmed not working on Android, presumed not working on iOS
//worked on windows (but returned null with type NULL instead of true)
Future<bool> copyWithClippy(String string)async{
  //return await copyWithClipboardManager(string);
  //TODO: uncomment when ready to release (leave commented for quick debuggin on Android)
  return await clippy.write(string);
}

//should only work for mobile
//confirmed working on Android, presumed workin on iOS
//did not work on windows, presume only mobile as indicated
copyWithClipboardManager(String string)async{
  return await FlutterClipboardManager.copyToClipBoard(string);
}

//MIGHT work with both (unknwon untested)
//confirmed working on Android, presumed workin on iOS
//did not work on windows, presume only mobile
copyWithFlutterClipboardManager(String string)async{
  return await ClipboardManager.copyToClipBoard(string);
}