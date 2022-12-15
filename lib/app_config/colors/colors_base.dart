import "dart:ui";

import "package:app/app_config/colors/app_colors.dart";

abstract class ColorsBase {
  /// Page
  final Color pageRootBg = AppColors.transparent;
  final Color pageBg = AppColors.transparent;

  /// Containers
  final Color containerBg = AppColors.transparent;
  final Color containerDarkBg = AppColors.transparent;
  final Color infoContainerBg1 = AppColors.transparent;
  final Color infoContainerBg2 = AppColors.transparent;
  final Color infoContainerBg3 = AppColors.transparent;
  final Color infoContainerBg4 = AppColors.transparent;
  final Color infoContainerBg5 = AppColors.transparent;
  final Color infoContainerBg6 = AppColors.transparent;
  final Color containerBorder = AppColors.transparent;

  /// Texts
  final Color textPrimary = AppColors.transparent;
  final Color textSecondary = AppColors.transparent;
  final Color textTernary = AppColors.transparent;
  final Color textLink = AppColors.transparent;
  final Color textError = AppColors.transparent;
  final Color textFocusing = AppColors.transparent;

  /// Input fields
  final Color inputFieldBg = AppColors.transparent;

  /// Buttons
  final Color buttonFilledBg = AppColors.transparent;
  final Color buttonFilledContent = AppColors.transparent;
  final Color buttonHollowBg = AppColors.transparent;
  final Color buttonHollowBorder = AppColors.transparent;
  final Color buttonHollowContent = AppColors.transparent;
  final Color buttonHollowContent2 = AppColors.transparent;
  final Color iconButton = AppColors.transparent;
  final Color secondaryIconButton = AppColors.transparent;

  /// Tabs
  final Color tabIndicatorBg = AppColors.transparent;
  final Color tabIndicator = AppColors.transparent;
  final Color tabLabel = AppColors.transparent;
  final Color tabSelectedLabel = AppColors.transparent;

  /// App Bar
  final Color appBarBg = AppColors.transparent;
  final Color appBarBgTransparent = AppColors.transparent;
  final Color appBarAvatarIcon = AppColors.transparent;
  final Color appBarAvatarBg = AppColors.transparent;

  /// Bottom Navigation
  final Color bottomNavBg = AppColors.transparent;
  final Color bottomNavIndicator = AppColors.transparent;
  final Color bottomNavItemBg = AppColors.transparent;
  final Color bottomNavItemActive = AppColors.transparent;
  final Color bottomNavItemInactive = AppColors.transparent;

  /// Drawer
  final Color drawerBg = AppColors.transparent;
  final Color drawerAvatarIcon = AppColors.transparent;
  final Color drawerAvatarBg = AppColors.transparent;
  final Color drawerItem = AppColors.transparent;
  final Color drawerLogInItem = AppColors.transparent;
  final Color drawerLogOutItem = AppColors.transparent;

  /// Carousal Indicator
  final Color carousalIndicator = AppColors.transparent;
  final Color carousalIndicatorActive = AppColors.transparent;

  /// Floating Message (SnackBar or Dialog)
  final Color floatingMessagesHelp = AppColors.transparent;
  final Color floatingMessagesFailure = AppColors.transparent;
  final Color floatingMessagesSuccess = AppColors.transparent;
  final Color floatingMessagesWarning = AppColors.transparent;

  /// Shadows
  final Color shadow = AppColors.transparent;
  final Color shadowLighter = AppColors.transparent;

  /// Outlines
  final Color outline = AppColors.transparent;
  final Color outlineFocused = AppColors.transparent;
  final Color outlineError = AppColors.transparent;

  /// Splash
  final Color splash = AppColors.transparent;

  /// Content
  final Color contentItemBg = AppColors.transparent;
  final Color contentItemSelectedBg = AppColors.transparent;
  final Color contentItemText = AppColors.transparent;
  final Color contentItemLock = AppColors.transparent;
  final Color contentItemContentSelected = AppColors.transparent;
  final Color contentItemContentLocked = AppColors.transparent;

  /// Video
  final Color videoBg = AppColors.transparent;
  final Color videoProgressIndicator = AppColors.transparent;
  final Color videoProgressPlayed = AppColors.transparent;
  final Color videoProgressHandle = AppColors.transparent;
  final Color videoItemIcon = AppColors.transparent;

  /// Quiz
  final Color quizItemIcon = AppColors.transparent;
  final Color quizTimerBg = AppColors.transparent;
  final Color quizTimerProgress = AppColors.transparent;
  final Color quizCurrentBorder = AppColors.transparent;
  final Color quizUnansweredBg = AppColors.transparent;
  final Color quizUnansweredBg2 = AppColors.transparent;
  final Color quizUnansweredBorder = AppColors.transparent;
  final Color quizAnsweredBg = AppColors.transparent;
  final Color quizAnsweredContent = AppColors.transparent;
  final Color quizCorrectBg = AppColors.transparent;
  final Color quizCorrectBgLight = AppColors.transparent;
  final Color quizCorrectBorder = AppColors.transparent;
  final Color quizIncorrectBg = AppColors.transparent;
  final Color quizIncorrectBgLight = AppColors.transparent;
  final Color quizIncorrectBorder = AppColors.transparent;

  /// Resource
  final Color resourceItemIcon = AppColors.transparent;

  /// Progress
  final Color progressBg = AppColors.transparent;
  final Color progressBgOnDark = AppColors.transparent;
  final Color progress = AppColors.transparent;
  final Color progressOnDark = AppColors.transparent;

  /// Miscellaneous
  final Color transparent = AppColors.transparent;
  final Color divider = AppColors.transparent;
  final Color courseCategoryChipBg = AppColors.transparent;
  final Color price = AppColors.transparent;
  final Color strikethroughPrice = AppColors.transparent;
  final Color strikethroughPrice2 = AppColors.transparent;
  final Color priceBg = AppColors.transparent;
  final Color pendingCoursePriceBg = AppColors.transparent;
  final Color enrolledCoursePriceBg = AppColors.transparent;
  final Color widgetCheckBoxSelectedShade = AppColors.transparent;
  final Color contentOnDark = AppColors.transparent;
  final Color acsvAutoScrollHighlight = AppColors.transparent;
  final Color textSuccess = AppColors.transparent;

  /// Private const constructor
  const ColorsBase._();
}
