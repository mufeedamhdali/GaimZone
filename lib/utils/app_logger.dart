import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

class AppLogger {
  static log(String message) {
    if (!kReleaseMode) {
      if (kDebugMode) {
        print(message);
      }
    }
  }
}

class DebugLogger {
  static log(String type, String tag, String url, String payload) {
    if (!kReleaseMode) {
      dev.log("$type: | $tag | $url \nPayLoad: $payload");
    }
  }
}
