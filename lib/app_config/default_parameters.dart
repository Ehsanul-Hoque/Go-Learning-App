import "package:app/utils/app_colors.dart";
import "package:flutter/widgets.dart";

class DefaultParameters {
  /// Dimensions
  static const double defaultBorderRadiusValue = 8;
  static const double defaultLargeSpacingValue = 24;
  static const double defaultNormalSpacingValue = 16;
  static const double defaultSmallSpacingValue = 8;
  static const double defaultBottomNavBarHeight = 56;
  static const double defaultBottomNavBarContentMinWidth = 56;

  /// Paddings, Margins and Borders
  static const EdgeInsets defaultNormalInsetAll =
      EdgeInsets.all(defaultNormalSpacingValue);
  static const EdgeInsets defaultSmallInsetAll =
      EdgeInsets.all(defaultSmallSpacingValue);
  static const BorderRadius defaultBorderRadius =
      BorderRadius.all(Radius.circular(defaultBorderRadiusValue));

  /// Animations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);
  static const Curve defaultAnimationCurve = Curves.easeInOut;

  /// Texts
  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 14,
    fontFamily: "Poppins",
  );

  /// Shadows
  static const BoxShadow defaultShadow = BoxShadow(
    color: AppColors.shadowGrey,
    spreadRadius: 0,
    offset: Offset(0, 1),
    blurRadius: 6,
  );

  /// Colors
  static const Color defaultTabIndicatorColor = AppColors.themeBlue;
  static const Color defaultTabIndicatorBgColor = Color(0x1A28295b);
}
