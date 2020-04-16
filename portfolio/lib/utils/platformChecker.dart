import 'dart:io';

//we pretend fuchsia doesn't exist

bool isMobile(){
  return Platform.isAndroid || Platform.isIOS;
}

bool isNotMobile(){
  return (isMobile() == false);
}

bool isWeb(){
  return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
}

//specific systems

bool isAndroid(){
  return Platform.isAndroid;
}

bool isiOS(){
  return Platform.isIOS;
}