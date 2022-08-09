part of "package:app/app_config/resources.dart";

class Dimensions {
  /// const constructor
  const Dimensions();

  /// Border
  final double defaultBorderRadiusValue = 8;
  final double fullRoundedBorderRadiusValue = 9999;
  final double defaultBorderThickness = 1;

  /// Spacings
  final double extraSmallSpacingValue = 4;
  final double smallSpacingValue = 8;
  final double mediumSmallSpacingValue = 12;
  final double normalSpacingValue = 16;
  final double mediumLargeSpacingValue = 20;
  final double largeSpacingValue = 24;
  final double hugeSpacingValue = 48;

  /// Widths and heights
  final double bottomNavBarContentMinWidth = 56;
  final double bottomNavBarHeight = 56;
  final double tabIndicatorHeight = 2;
  final double tabBarBottomBorderThickness = 1;
  final double inputFieldHeight = 56;
  final double buttonHeight = 56;
  final double iconSizeSmall = 20;
  final double iconSizeNormal = 24;
  final double fontSizeSmall = 12;
  final double fontSizeNormal = 14;
  final double fontSizeMedium = 16;
  final double fontSizeLarge = 18;

  /// Paddings, Margins and Borders
  /*final EdgeInsets defaultLargeInsetAll =
  EdgeInsets.all(defaultLargeSpacingValue);
  final EdgeInsets defaultNormalInsetAll =
  EdgeInsets.all(defaultNormalSpacingValue);
  final EdgeInsets defaultSmallInsetAll =
  EdgeInsets.all(defaultSmallSpacingValue);
  final BorderRadius defaultBorderRadius =
  BorderRadius.all(Radius.circular(defaultBorderRadiusValue));
  final BorderRadius fullRoundedBorderRadius =
  BorderRadius.all(Radius.circular(fullRoundedBorderRadiusValue));*/
}

class TextStyles {
  const TextStyles();

  TextStyle get general => TextStyle(
        fontSize: Res.dimen.fontSizeNormal,
        // fontFamily: "Poppins",
        color: Res.color.textPrimary,
      );

  TextStyle get secondary => general.copyWith(
        color: Res.color.textSecondary,
      );

  TextStyle get ternary => general.copyWith(
        color: Res.color.textTernary,
      );

  TextStyle get link => general.copyWith(
        color: Res.color.textLink,
        fontWeight: FontWeight.w500,
      );

  TextStyle get error => general.copyWith(
        color: Res.color.textError,
      );

  TextStyle get button => general.copyWith(
        fontWeight: FontWeight.w500,
      );

  TextStyle get tabSelectedLabel => button;
}

class AnimationParams {
  const AnimationParams();

  final Duration defaultDuration = const Duration(milliseconds: 200);
  final Curve defaultCurve = Curves.easeInOut;
}

class Shadows {
  const Shadows();

  BoxShadow get normal => BoxShadow(
        color: Res.color.shadow,
        offset: const Offset(0, 1),
        blurRadius: 6,
      );
}
