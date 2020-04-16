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