// ignore_for_file: annotate_overrides

import "dart:ui";

import "package:app/app_config/colors/colors_base.dart";
import "package:app/app_config/colors/app_colors.dart";

class ColorsLightMode implements ColorsBase {
  /// Page
  final Color pageRootBg = AppColors.black;
  final Color pageBg = AppColors.veryLightGreyOne;

  /// Containers
  final Color containerBg = AppColors.white;
  final Color containerDarkBg = AppColors.grey900;
  final Color infoContainerBg1 = AppColors.blueAccent100Alpha50;
  final Color infoContainerBg2 = AppColors.flatGreenEmeraldAlpha50;
  final Color infoContainerBg3 = AppColors.purple100Alpha50;
  final Color infoContainerBg4 = AppColors.redAccent100Alpha50;
  final Color infoContainerBg5 = AppColors.grey600Alpha50;
  final Color infoContainerBg6 = AppColors.blueGrey300Alpha50;

  /// Texts
  final Color textPrimary = AppColors.grey900;
  final Color textSecondary = AppColors.grey600;
  final Color textTernary = AppColors.grey400;
  final Color textLink = AppColors.flatBluePeterRiver;
  final Color textError = AppColors.redAccent;
  final Color textFocusing = AppColors.flatRedAlizarin;

  /// Input fields
  final Color inputFieldBg = AppColors.transparent;

  /// Buttons
  final Color buttonFilledBg = AppColors.themeYellow;
  final Color buttonFilledContent = AppColors.white;
  final Color buttonHollowBg = AppColors.transparent;
  final Color buttonHollowBorder = AppColors.grey300;
  final Color buttonHollowContent = AppColors.black;
  final Color buttonHollowContent2 = AppColors.grey600;
  final Color iconButton = AppColors.black;
  final Color secondaryIconButton = AppColors.grey600;

  /// Tabs
  final Color tabIndicatorBg = AppColors.grey300;
  final Color tabIndicator = AppColors.themeBlue;
  final Color tabLabel = AppColors.themeBlueAlpha60;
  final Color tabSelectedLabel = AppColors.themeBlue;

  /// App Bar
  final Color appBarBg = AppColors.veryLightGreyTwo;
  final Color appBarBgTransparent = AppColors.transparent;
  final Color appBarAvatarIcon = AppColors.white;
  final Color appBarAvatarBg = AppColors.themeYellow;

  /// Bottom Navigation
  final Color bottomNavBg = AppColors.white;
  final Color bottomNavIndicator = AppColors.themeYellow;
  final Color bottomNavItemBg = AppColors.transparent;
  final Color bottomNavItemActive = AppColors.white;
  final Color bottomNavItemInactive = AppColors.themeBlue;

  /// Drawer
  final Color drawerBg = AppColors.grey300;
  final Color drawerAvatarIcon = AppColors.white;
  final Color drawerAvatarBg = AppColors.themeYellow;
  final Color drawerItem = AppColors.themeBlue;
  final Color drawerLogOutItem = AppColors.redAccent;

  /// Carousal Indicator
  final Color carousalIndicator = AppColors.grey300;
  final Color carousalIndicatorActive = AppColors.themeYellow;

  /// Floating Message (SnackBar or Dialog)
  final Color floatingMessagesHelp = AppColors.flatBluePeterRiver;
  final Color floatingMessagesFailure = AppColors.flatRedAlizarin;
  final Color floatingMessagesSuccess = AppColors.flatGreenEmerald;
  final Color floatingMessagesWarning = AppColors.flatOrangeQuinceJelly;

  /// Shadows
  final Color shadow = AppColors.shadowGrey;
  final Color shadowLighter = AppColors.shadowLightGrey;

  /// Outlines
  final Color outline = AppColors.grey300;
  final Color outlineFocused = AppColors.themeBlue;
  final Color outlineError = AppColors.redAccent;

  /// Splash
  final Color splash = AppColors.themeBlueAlpha10;

  /// Content
  final Color contentItemBg = AppColors.white;
  final Color contentItemSelectedBg = AppColors.themeYellow;
  final Color contentItemText = AppColors.grey900;
  final Color contentItemLock = AppColors.grey600;
  final Color contentItemContentSelected = AppColors.white;
  final Color contentItemContentLocked = AppColors.grey400;

  /// Video
  final Color videoBg = AppColors.themeBlue;
  final Color videoProgressIndicator = AppColors.themeYellow;
  final Color videoProgressPlayed = AppColors.themeYellow;
  final Color videoProgressHandle = AppColors.flatYellowSunflower;
  final Color videoItemIcon = AppColors.themeYellow;

  /// Quiz
  final Color quizItemIcon = AppColors.flatBluePeterRiver;
  final Color quizTimerBg = AppColors.grey300;
  final Color quizTimerProgress = AppColors.flatPurpleShyMoment;
  final Color quizCurrentBorder = AppColors.themeYellow;
  final Color quizUnansweredBg = AppColors.grey300;
  final Color quizUnansweredBg2 = AppColors.veryLightGreyOne;
  final Color quizUnansweredBorder = AppColors.grey300;
  final Color quizAnsweredBg = AppColors.themeYellow;
  final Color quizAnsweredContent = AppColors.white;
  final Color quizCorrectBg = AppColors.flatGreenEmerald;
  final Color quizCorrectBgLight = AppColors.flatGreenEmeraldAlpha20;
  final Color quizCorrectBorder = AppColors.flatGreenEmerald;
  final Color quizIncorrectBg = AppColors.flatRedAlizarin;
  final Color quizIncorrectBgLight = AppColors.flatRedAlizarinAlpha20;
  final Color quizIncorrectBorder = AppColors.flatRedAlizarin;

  /// Resource
  final Color resourceItemIcon = AppColors.flatPurpleAmethyst;

  /// Progress
  final Color progressBg = AppColors.themeBlueAlpha10;
  final Color progress = AppColors.themeBlue;

  /// Miscellaneous
  final Color transparent = AppColors.transparent;
  final Color divider = AppColors.grey300;
  final Color price = AppColors.themeBlue;
  final Color strikethroughPrice = AppColors.whiteAlpha60;
  final Color strikethroughPrice2 = AppColors.themeBlueAlpha60;
  final Color priceBg = AppColors.white;
  final Color widgetCheckBoxSelectedShade = AppColors.flatGreenEmeraldAlpha90;
  final Color contentOnDark = AppColors.white;
  final Color acsvAutoScrollHighlight = AppColors.themeYellowAlpha05;
  final Color textSuccess = AppColors.flatGreenEmerald;

  /// const constructor
  const ColorsLightMode();
}
