//since I'm only working within flutter web I don't need to check the platform
import 'package:flutter/foundation.dart' show kIsWeb;

bool isWeb() {
  return kIsWeb;
}

bool isAndroid() {
  return false;
}

bool isiOS() {
  return false;
}
