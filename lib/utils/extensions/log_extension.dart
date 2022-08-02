import "dart:developer" as devtools show log;

import "package:flutter/foundation.dart";

extension LogExtension on Object {
  void log() {
    if (kDebugMode) {
      devtools.log(toString(), time: DateTime.now());
    }
  }
}
