//for is web check
import 'package:flutter/foundation.dart' show kIsWeb;

//for platform check
import 'dart:io';

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
    return Platform.isAndroid 
    || Platform.isIOS;
  }
}

bool isDesktop(){
  if(isWeb()){
    return false;
  }
  else {
    return Platform.isWindows 
    || Platform.isLinux 
    || Platform.isMacOS;
  }
}

//mobile specifics

bool isAndroid(){
  if(isWeb()){
    return false;
  }
  else {
    return Platform.isAndroid;
  }
}

bool isiOS(){
  if(isWeb()){
    return false;
  }
  else {
    return Platform.isIOS;
  }
}

//desktop specifics

bool isWindows(){
  if(isWeb()){
    return false;
  }
  else {
    return Platform.isWindows;
  }
}

bool isLinux(){
  if(isWeb()){
    return false;
  }
  else {
    return Platform.isLinux;
  }
}

bool isMac(){
  if(isWeb()){
    return false;
  }
  else {
    return Platform.isMacOS;
  }
}