import 'dart:io';

//we pretend fuchsia doesn't exist

isMobile(){
  return Platform.isAndroid 
  || Platform.isIOS;
}

isWeb(){
  return Platform.isWindows 
  || Platform.isLinux 
  || Platform.isMacOS;
}

//specific systems

isAndroid(){
  return Platform.isAndroid;
}

isiOS(){
  return Platform.isIOS;
}