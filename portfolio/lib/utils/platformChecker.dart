//for is web check
import 'package:flutter/foundation.dart' show kIsWeb;

//for platform check
import 'package:universal_platform/universal_platform.dart';

//NOTE: platform checking breaks in web so we work with that

//we pretend fuchsia doesn't exist

bool isWeb(){
  return kIsWeb;
}

bool isMobile(){
  if(isWeb()){
    return false;
  }
  else{
    return UniversalPlatform.isAndroid 
    || UniversalPlatform.isIOS;
  }
}

bool isDesktop(){
  if(isWeb()){
    return false;
  }
  else {
    return UniversalPlatform.isWindows 
    || UniversalPlatform.isLinux 
    || UniversalPlatform.isMacOS;
  }
}

//mobile specifics

bool isAndroid(){
  if(isWeb()){
    return false;
  }
  else {
    return UniversalPlatform.isAndroid;
  }
}

bool isiOS(){
  if(isWeb()){
    return false;
  }
  else {
    return UniversalPlatform.isIOS;
  }
}

//desktop specifics

bool isWindows(){
  if(isWeb()){
    return false;
  }
  else {
    return UniversalPlatform.isWindows;
  }
}

bool isLinux(){
  if(isWeb()){
    return false;
  }
  else {
    return UniversalPlatform.isLinux;
  }
}

bool isMac(){
  if(isWeb()){
    return false;
  }
  else {
    return UniversalPlatform.isMacOS;
  }
}