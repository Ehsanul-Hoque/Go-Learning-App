import "dart:ui";

import "package:app/app_config/colors/app_colors.dart";

abstract class ColorsBase {
  /// Page
  final Color pageRootBg = AppColors.transparent;
  final Color pageBg = AppColors.transparent;

  /// Containers
  final Color containerBg = AppColors.transparent;
  final Color infoContainerBg1 = AppColors.transparent;
  final Color infoContainerBg2 = AppColors.transparent;
  final Color infoContainerBg3 = AppColors.transparent;

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
  final Color drawerLogOutItem = AppColors.transparent;

  /// Carousal Indicator
  final Color carousalIndicator = AppColors.transparent;
  final Color carousalIndicatorActive = AppColors.transparent;

  /// SnackBar
  final Color snackBarHelp = AppColors.transparent;
  final Color snackBarFailure = AppColors.transparent;
  final Color snackBarSuccess = AppColors.transparent;
  final Color snackBarWarning = AppColors.transparent;

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

  /// Resource
  final Color resourceItemIcon = AppColors.transparent;

  /// Miscellaneous
  final Color transparent = AppColors.transparent;
  final Color divider = AppColors.transparent;
  final Color price = AppColors.transparent;
  final Color strikethroughPrice = AppColors.transparent;
  final Color priceBg = AppColors.transparent;
  final Color widgetCheckBoxSelectedShade = AppColors.transparent;
  final Color contentOnDark = AppColors.transparent;

  /// Private const constructor
  const ColorsBase._();
}
