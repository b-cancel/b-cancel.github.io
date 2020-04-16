import 'dart:io';

//we assume fuchsia is both mobile and web
//NOTE: this will probably cause things to break

isMobile(){
  return Platform.isAndroid 
  || Platform.isIOS
  || Platform.isFuchsia;
}

isWeb(){
  return Platform.isWindows 
  || Platform.isLinux 
  || Platform.isMacOS 
  || Platform.isFuchsia;
}