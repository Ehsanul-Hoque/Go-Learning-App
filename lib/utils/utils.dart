import "dart:developer" as devtools show log;

import "package:flutter/foundation.dart";

class Utils {
  static void log(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Object? extra,
  }) {
    if (kDebugMode) {
      devtools.log(
        message,
        time: DateTime.now(),
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
