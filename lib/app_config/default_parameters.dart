import "package:app/utils/app_colors.dart";
import "package:flutter/widgets.dart";

class DefaultParameters {
  /// Dimensions
  static const double defaultBorderRadiusValue = 8;
  static const double fullRoundedBorderRadiusValue = 9999;
  static const double defaultExtraSmallSpacingValue = 4;
  static const double defaultSmallSpacingValue = 8;
  static const double defaultMediumSmallSpacingValue = 12;
  static const double defaultNormalSpacingValue = 16;
  static const double defaultMediumLargeSpacingValue = 20;
  static const double defaultLargeSpacingValue = 24;
  static const double defaultBottomNavBarHeight = 56;
  static const double defaultBottomNavBarContentMinWidth = 56;
  static const double defaultInputFieldHeight = 56;
  static const double defaultButtonHeight = 56;
  static const double defaultIconSize = 24;

  /// Paddings, Margins and Borders
  static const EdgeInsets defaultLargeInsetAll =
      EdgeInsets.all(defaultLargeSpacingValue);
  static const EdgeInsets defaultNormalInsetAll =
      EdgeInsets.all(defaultNormalSpacingValue);
  static const EdgeInsets defaultSmallInsetAll =
      EdgeInsets.all(defaultSmallSpacingValue);
  static const BorderRadius defaultBorderRadius =
      BorderRadius.all(Radius.circular(defaultBorderRadiusValue));
  static const BorderRadius fullRoundedBorderRadius =
      BorderRadius.all(Radius.circular(fullRoundedBorderRadiusValue));

  /// Animations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 200);
  static const Curve defaultAnimationCurve = Curves.easeInOut;

  /// Texts
  static const TextStyle defaultTextStyle = TextStyle(
    fontSize: 14,
    // fontFamily: "Poppins",
    color: AppColors.black,
  );
  static const TextStyle secondaryTextStyle = TextStyle(
    fontSize: 14,
    // fontFamily: "Poppins",
    color: AppColors.grey600,
  );
  static const TextStyle labelTextStyle = TextStyle(
    fontSize: 14,
    // fontFamily: "Poppins",
    color: AppColors.blackAlpha60,
  );
  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    // fontFamily: "Poppins",
    color: AppColors.flatBlue,
    fontWeight: FontWeight.w500,
  );

  /// Shadows
  static const BoxShadow defaultShadow = BoxShadow(
    color: AppColors.shadowGrey,
    spreadRadius: 0,
    offset: Offset(0, 1),
    blurRadius: 6,
  );

  /// Colors
  static const Color defaultPageBgColor = AppColors.veryLightGrey;
  static const Color defaultTabIndicatorBgColor = AppColors.grey300;
  static const Color defaultTabIndicatorColor = AppColors.themeBlue;
  static const Color defaultButtonBgColor = AppColors.themeYellowAlpha80;
  static const Color defaultButtonContentColor = AppColors.white;
  static const Color defaultIconButtonColor = AppColors.black;
  static const Color secondaryIconButtonColor = AppColors.grey600;
}
