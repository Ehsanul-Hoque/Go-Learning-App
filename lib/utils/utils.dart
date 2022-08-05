import "dart:developer" as devtools show log;

import "package:app/app_config/default_parameters.dart";
import "package:app/utils/app_colors.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

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

  static InputDecoration getAppInputDecoration({
    String? hint,
    String? label,
    double borderRadius = DefaultParameters.defaultBorderRadiusValue,
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
    Color? enabledBorderColor,
    Color? focusedBorderColor,
    Color? backgroundColor,
    EdgeInsets? contentPadding,
    bool? isCollapsed,
    bool? isDense,
  }) {
    hintOrLabelColor ??= AppColors.grey600;
    enabledBorderColor ??= AppColors.grey300;
    focusedBorderColor ??= AppColors.themeBlue;

    return InputDecoration(
      hintText: hint,
      hintStyle: DefaultParameters.defaultTextStyle.copyWith(
        color: hintOrLabelColor,
      ),
      helperStyle: DefaultParameters.defaultTextStyle.copyWith(
        color: AppColors.grey400,
        fontSize: 12,
      ),
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: DefaultParameters.defaultTextStyle.copyWith(
        color: hintOrLabelColor,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: focusedBorderColor,
          width: 1,
        ),
      ),
      errorStyle: DefaultParameters.defaultTextStyle.copyWith(
        color: AppColors.redAccent,
        fontSize: 12,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: AppColors.redAccent,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: AppColors.redAccent,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: enabledBorderColor,
          width: 1,
        ),
      ),
      fillColor: backgroundColor,
      filled: backgroundColor != null ? true : false,
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
}
