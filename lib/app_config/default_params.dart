part of "package:app/app_config/resources.dart";

class Dimensions {
  /// const constructor
  const Dimensions();

  /// Border
  final double defaultBorderRadiusValue = 8;
  final double mediumBorderRadiusValue = 12;
  final double largeBorderRadiusValue = 16;
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
  final double xxlSpacingValue = 32;
  final double hugeSpacingValue = 48;
  final double carousalItemSpacing = 16;
  final double appBarAvatarRadiusToHolePaddingRatio = 1 / 5;
  final double appBarAvatarCenterX = 60;
  final double navBarMargin = 8;
  final double drawerTopMargin = 88;
  final double pageBottomPaddingWithNavBar = 96;
  double getPageTopPaddingWithAppBar(BuildContext context) {
    return MediaQuery.of(context).padding.top +
        56 +
        30 +
        16; // toolbarHeight + appBarAvatarRadius + normalSpacingValue
  }

  /// Widths and heights
  final double toolbarHeight = 56;
  final double bottomNavBarContentMinWidth = 56;
  final double bottomNavBarHeight = 56;
  final double carousalIndicatorItemSize = 12;
  final double tabIndicatorHeight = 2;
  final double tabBarBottomBorderThickness = 1;
  final double inputFieldHeight = 56;
  final double buttonHeight = 56;
  final double iconSizeXxs = 12;
  final double iconSizeSmall = 20;
  final double iconSizeNormal = 20;
  final double iconSizeHuge = 48;
  final double fontSizeSmall = 12;
  final double fontSizeNormal = 14;
  final double fontSizeMedium = 16;
  final double fontSizeLarge = 18;
  final double fontSizeXl = 20;
  final double fontSizeXXl = 22;
  final double fontSizeXXXl = 24;
  final double pageLoadingSize = 200;
  final double appBarAvatarRadius = 30;
  final double appBarAvatarToHoleFilletRadiusRatio = 1 / 5;
  final double drawerAvatarRadius = 48;
  final double courseItemWidth = 225;
  final double courseItemDescriptionHeight = 76;
  double getCourseItemHeight(double width) =>
      // (width * bannerAspectRatio^-1) + courseItemDescriptionHeight
      (width * (1 / bannerAspectRatio)) + 76;

  /// Ratio
  // final double bannerAspectRatioWidth = 16;
  // final double bannerAspectRatioHeight = 9;
  final double bannerAspectRatio = 16 / 9;
  final double bannerAspectRatioAfterPadding = 16 / 7.5;
  final double videoAspectRatio = 16 / 9;

  /// Floating Message (SnackBar or Dialog)
  final double snackBarMaxWidth = 480;
  final double snackBarContentLeftPadding = 64;
  final double floatingMessagesBubbleImageSize = 42;
  final double floatingMessagesTopBubbleTop = -20;
  final double appDialogTopBubbleRight = -20;
  final double floatingMessagesTopBubbleSize = 48;
  final double floatingMessagesTopBubbleIconTop = 12;
  final double floatingMessagesTopBubbleIconHeight = 20;

  /// Miscellaneous
  final double maxWidthSmall = 348;
  final double maxWidthNormal = 512;
  final double homeBannerViewportFraction = 0.8;
  final double checkoutPaymentMethodsMaxWidth = 348;
  final double quizCurrentQuesNumBorderThickness = 2;
  final double inViewTopLimitFraction = 0.4;
  final double inViewBottomLimitFraction = 1.1;
  final double quizQuesBottomBorderToMaxWidthRatio = 1.5;
}

class TextStyles {
  const TextStyles();

  TextStyle get general => TextStyle(
        fontSize: Res.dimen.fontSizeNormal,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
        color: Res.color.textPrimary,
        height: 1.2,
      );

  TextStyle get secondary => general.copyWith(color: Res.color.textSecondary);

  TextStyle get ternary => general.copyWith(color: Res.color.textTernary);

  TextStyle get header => general.copyWith(
        fontSize: Res.dimen.fontSizeXXXl,
        fontWeight: FontWeight.w500,
      );

  TextStyle get label => general.copyWith(
        fontSize: Res.dimen.fontSizeLarge,
        fontWeight: FontWeight.w500,
      );

  TextStyle get labelSmall =>
      general.copyWith(fontSize: Res.dimen.fontSizeMedium);

  TextStyle get subLabel => general;

  TextStyle get link => general.copyWith(
        color: Res.color.textLink,
        fontWeight: FontWeight.w500,
      );

  TextStyle get error => general.copyWith(color: Res.color.textError);

  TextStyle get button => general.copyWith(fontWeight: FontWeight.w500);
  TextStyle get buttonBold => general.copyWith(fontWeight: FontWeight.bold);
  TextStyle get tabSelectedLabel => button;

  TextStyle get focusing => general.copyWith(
        color: Res.color.textFocusing,
        fontWeight: FontWeight.w500,
      );

  TextStyle get small => general.copyWith(fontSize: Res.dimen.fontSizeSmall);
  TextStyle get smallThick => small.copyWith(fontWeight: FontWeight.w500);

  TextStyle get h1 => general.copyWith(fontSize: Res.dimen.fontSizeXXXl);
  TextStyle get h2 => general.copyWith(fontSize: Res.dimen.fontSizeXXl);
  TextStyle get h3 => general.copyWith(fontSize: Res.dimen.fontSizeXl);
  TextStyle get h4 => general.copyWith(fontSize: Res.dimen.fontSizeLarge);
  TextStyle get h5 => general.copyWith(fontSize: Res.dimen.fontSizeMedium);
  TextStyle get h6 => general.copyWith(fontSize: Res.dimen.fontSizeNormal);
}

class Durations {
  const Durations();

  final Duration defaultDuration = const Duration(milliseconds: 200);
  // final Duration animatedSwitcherDuration = const Duration(milliseconds: 500);
  final Duration fakeLoadingDuration = const Duration(milliseconds: 200);
}

class MyCurves {
  const MyCurves();

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

  /// Icons
  final String icGoogleSvg = "assets/icons/ic_google.svg";
  final String icHelpSvg = "assets/icons/ic_help.svg";
  final String icFailureSvg = "assets/icons/ic_failure.svg";
  final String icSuccessSvg = "assets/icons/ic_success.svg";
  final String icWarningSvg = "assets/icons/ic_warning.svg";
  final String icHomeSvg = "assets/icons/ic_home.svg";
  final String icExploreSvg = "assets/icons/ic_explore.svg";
  final String icBookmarkSvg = "assets/icons/ic_bookmark.svg";
  final String icExamSvg = "assets/icons/ic_exam.svg";
  final String icEditProfileSvg = "assets/icons/ic_edit_profile.svg";
  final String icTermsOfUseSvg = "assets/icons/ic_terms.svg";
  final String icLogOutSvg = "assets/icons/ic_logout.svg";
  final String icPlaySvg = "assets/icons/ic_play.svg";
  final String icQuizSvg = "assets/icons/ic_quiz.svg";
  final String icResourceSvg = "assets/icons/ic_resource.svg";
  final String icTipsSvg = "assets/icons/ic_tips.svg";

  /// Illustrations
  final String loadingSvg = "assets/illustrations/loading.svg";
  final String defaultAvatarSvg = "assets/illustrations/default_avatar.svg";
  final String talkBubbleSvg = "assets/illustrations/talk_bubble.svg";
  final String cornerBubblesSvg = "assets/illustrations/corner_bubbles.svg";

  /// Logos
  final String logoSvg = "assets/logo/logo.svg";
  final String logoBkashPng = "assets/logo/logo_bkash.png";
  final String logoNagadPng = "assets/logo/logo_nagad.png";
  final String logoRocketPng = "assets/logo/logo_rocket.png";
}
