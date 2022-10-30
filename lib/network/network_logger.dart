import "package:flutter/foundation.dart";
import "package:logger/logger.dart";

class NetLog {
  /// Fields
  static const int defaultMethodCount = 0;
  static const int defaultStackTraceMethodCount = 8;
  static bool enabled = kDebugMode;

  final LogPrinter _printer;

  NetLog({
    int methodCount = defaultMethodCount,
    int stackTraceMethodCount = defaultStackTraceMethodCount,
    bool printTime = true,
  }) : _printer = PrettyPrinter(
          methodCount: methodCount, // number of method calls to be displayed
          errorMethodCount:
              stackTraceMethodCount, // number of method calls if stacktrace is provided
          lineLength: 120, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: printTime, // Should each log print contain a timestamp
        );

  // Verbose logging
  void v(
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    bool showLog = true,
  }) {
    if (enabled && showLog) {
      Logger(printer: _printer).v(message, error, stackTrace);
    }
  }

  // Debug logging
  void d(
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    bool showLog = true,
  }) {
    if (enabled && showLog) {
      Logger(printer: _printer).d(message, error, stackTrace);
    }
  }

  // Info logging
  void i(
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    bool showLog = true,
  }) {
    if (enabled && showLog) {
      Logger(printer: _printer).i(message, error, stackTrace);
    }
  }

  // Warning logging
  void w(
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    bool showLog = true,
  }) {
    if (enabled && showLog) {
      Logger(printer: _printer).w(message, error, stackTrace);
    }
  }

  // Error logging
  void e(
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    bool showLog = true,
  }) {
    if (enabled && showLog) {
      Logger(printer: _printer).e(message, error, stackTrace);
    }
  }

  // What A Terrible Failure logging
  void wtf(
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    bool showLog = true,
  }) {
    if (enabled && showLog) {
      Logger(printer: _printer).wtf(message, error, stackTrace);
    }
  }

  // General logging
  void log(
    Level level,
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    bool showLog = true,
  }) {
    if (enabled && showLog) {
      Logger(printer: _printer).log(level, message, error, stackTrace);
    }
  }
}
