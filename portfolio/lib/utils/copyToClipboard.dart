//import 'package:clippy/browser.dart' as clippy;
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
Future<bool> copyWithClippy(String string)async{
  return await copyWithClipboardManager(string);
  //return await clippy.write(string);
}

//should only work for mobile
copyWithClipboardManager(String string)async{
  return await FlutterClipboardManager.copyToClipBoard(string);
}

//MIGHT work with both (unknwon untested)
copyWithFlutterClipboardManager(String string)async{
  return await ClipboardManager.copyToClipBoard(string);
}