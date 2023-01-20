import "dart:convert";
import "dart:developer" as devtools show log;

import "package:app/app_config/resources.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart"
    show
        FloatingLabelBehavior,
        InputBorder,
        InputDecoration,
        OutlineInputBorder;
import "package:flutter/services.dart" show DeviceOrientation, SystemChrome;
import "package:flutter/widgets.dart";

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

  static void toggleFullScreenMode(bool makeFullScreen) {
    if (makeFullScreen) {
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations(<DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  static String getRandomString(int length) {
    if (length <= 0) {
      return "";
    } else if (length > 100) {
      length = 100;
    }

    List<String> allowedChars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            .split("");

    return allowedChars.getNonNullRandoms(length).join();
  }

  static String getModelString(
    String modelName,
    Map<String, dynamic> jsonRepresentation,
  ) {
    JsonEncoder jsonEncoder = const JsonEncoder.withIndent("  ");
    String formattedJson = jsonEncoder.convert(jsonRepresentation);

    /*return "\n-------------------------------------------------- [START]"
        "\n$modelName"
        "\n--------------------------------------------------"
        "\n$formattedJson"
        "\n-------------------------------------------------- [END]"
        "\n";*/

    return "\n------------------------- $modelName -------------------------"
        "\n$formattedJson"
        "\n";
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, 0.toString());

  static String getMmSsFormat(Duration duration) {
    String twoDigitMinutes = _twoDigits(duration.inMinutes);
    String twoDigitSeconds = _twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  static String getHhMmSsFormat(Duration duration) {
    String twoDigitHours = _twoDigits(duration.inHours);
    String twoDigitMinutes = _twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = _twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String formatDurationText(String durationText) {
    return durationText
        .trim()
        .toLowerCase()
        .replaceAll(" hours", "h")
        .replaceAll(" hour", "h")
        .replaceAll(" hr", "h")
        .replaceAll(" h", "h")
        .replaceAll(" minutes", "m")
        .replaceAll(" minute", "m")
        .replaceAll(" m", "m");
  }

  static Color getTransparent(Color color) => color.withOpacity(0);

  static InputDecoration getAppInputDecoration({
    String? hint,
    String? label,
    double? borderRadius,
    Widget? prefix,
    String? prefixText,
    Widget? prefixIcon,
    BoxConstraints? prefixIconConstraints,
    Widget? suffix,
    String? suffixText,
    Widget? suffixIcon,
    BoxConstraints? suffixIconConstraints,
    bool showCounterText = true,
    TextStyle? counterTextStyle,
    Color? hintOrLabelColor,
    Color? errorColor,
    Color? errorBorderColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? backgroundColor,
    double? borderThickness,
    double? focusedBorderThickness,
    double? errorBorderThickness,
    double? focusedErrorBorderThickness,
    EdgeInsets? contentPadding,
    bool? isCollapsed,
    bool? isDense,
    bool enabled = true,
  }) {
    borderRadius ??= Res.dimen.defaultBorderRadiusValue;
    hintOrLabelColor ??=
        enabled ? Res.color.textSecondary : Res.color.textTernary;
    errorColor ??= Res.color.textError;
    errorBorderColor ??= Res.color.outlineError;
    enabledBorderColor ??= Res.color.outline;
    focusedBorderColor ??= Res.color.outlineFocused;
    backgroundColor ??= Res.color.inputFieldBg;

    borderThickness ??= Res.dimen.defaultBorderThickness;
    focusedBorderThickness ??= Res.dimen.defaultBorderThickness;
    errorBorderThickness ??= borderThickness;
    focusedErrorBorderThickness ??= focusedBorderThickness;

    return InputDecoration(
      hintText: hint,
      hintStyle: Res.textStyles.secondary.copyWith(
        color: hintOrLabelColor,
      ),
      helperStyle: Res.textStyles.ternary.copyWith(
        fontSize: Res.dimen.fontSizeSmall,
      ),
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Res.textStyles.secondary.copyWith(
        color: hintOrLabelColor,
      ),
      border: getOutlineInputBorder(
        enabledBorderColor,
        borderRadius,
        borderThickness,
      ),
      focusedBorder: getOutlineInputBorder(
        focusedBorderColor,
        borderRadius,
        focusedBorderThickness,
      ),
      errorStyle: Res.textStyles.error.copyWith(
        color: errorColor,
        fontSize: Res.dimen.fontSizeSmall,
      ),
      errorBorder: getOutlineInputBorder(
        errorBorderColor,
        borderRadius,
        errorBorderThickness,
      ),
      focusedErrorBorder: getOutlineInputBorder(
        errorBorderColor,
        borderRadius,
        focusedErrorBorderThickness,
      ),
      enabledBorder: getOutlineInputBorder(
        enabledBorderColor,
        borderRadius,
        borderThickness,
      ),
      fillColor: backgroundColor,
      filled: true,
      contentPadding: contentPadding,
      isCollapsed: isCollapsed ?? false,
      isDense: isDense,
      prefix: prefix,
      prefixText: prefixText,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      suffix: suffix,
      suffixText: suffixText,
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      counterText: showCounterText ? null : "",
      counterStyle: counterTextStyle,
    );
  }

  static InputBorder getOutlineInputBorder(
    Color borderColor,
    double borderRadius,
    double borderThickness,
  ) {
    if (borderThickness == 0) {
      return InputBorder.none;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: borderColor,
        width: borderThickness,
      ),
    );
  }
}
