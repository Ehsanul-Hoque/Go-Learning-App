part of "package:app/app_config/resources.dart";

class Dimensions {
  /// const constructor
  const Dimensions();

  /// Border
  final double defaultBorderRadiusValue = 8;
  final double fullRoundedBorderRadiusValue = 9999;
  final double defaultBorderThickness = 1;

  /// Spacings
  final double xxsSpacingValue = 2;
  final double xsSpacingValue = 4;
  final double smallSpacingValue = 8;
  final double msSpacingValue = 12;
  final double normalSpacingValue = 16;
  final double mlSpacingValue = 20;
  final double largeSpacingValue = 24;
  final double hugeSpacingValue = 48;
  final double carousalItemSpacing = 16;

  /// Widths and heights
  final double bottomNavBarContentMinWidth = 56;
  final double bottomNavBarHeight = 56;
  final double carousalIndicatorItemSize = 12;
  final double tabIndicatorHeight = 2;
  final double tabBarBottomBorderThickness = 1;
  final double inputFieldHeight = 56;
  final double buttonHeight = 56;
  final double iconSizeXxs = 12;
  final double iconSizeSmall = 20;
  final double iconSizeNormal = 24;
  final double fontSizeSmall = 12;
  final double fontSizeNormal = 14;
  final double fontSizeMedium = 16;
  final double fontSizeLarge = 18;
  final double pageLoadingSize = 200;

  /// Ratio
  final double bannerAspectRatioWidth = 16;
  final double bannerAspectRatioHeight = 9;
  // final double bannerAspectRatio = 16 / 9;
  final double bannerAspectRatioAfterPadding = 16 / 7.5;

  /// Miscellaneous
  final double homeBannerViewportFraction = 0.8;

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

  TextStyle get label => general.copyWith(
        fontSize: Res.dimen.fontSizeLarge,
        fontWeight: FontWeight.w500,
      );

  TextStyle get subLabel => general.copyWith(
        fontSize: Res.dimen.fontSizeMedium,
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

  TextStyle get small => secondary.copyWith(
        fontSize: Res.dimen.fontSizeSmall,
      );
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

  BoxShadow get lighter => BoxShadow(
        color: Res.color.shadowLighter,
        offset: const Offset(0, 1),
        blurRadius: 4,
      );
}

class Assets {
  const Assets();

  final String icGoogleSvg = "assets/icons/ic_google.svg";
  final String loadingSvg = "assets/illustrations/loading.svg";
  final String logoSvg = "assets/logo/logo.svg";
}
