// ignore_for_file: annotate_overrides

import "dart:ui";

import "package:app/app_config/colors/colors_base.dart";
import "package:app/app_config/colors/app_colors.dart";

class ColorsLightMode implements ColorsBase {
  /// Page
  final Color pageRootBg = AppColors.black;
  final Color pageBg = AppColors.veryLightGrey;

  /// Containers
  final Color containerBg = AppColors.white;
  final Color infoContainerBg1 = AppColors.blueAccent100Alpha50;
  final Color infoContainerBg2 = AppColors.green100Alpha50;
  final Color infoContainerBg3 = AppColors.purple100Alpha50;

  /// Texts
  final Color textPrimary = AppColors.grey900;
  final Color textSecondary = AppColors.grey600;
  final Color textTernary = AppColors.grey400;
  final Color textLink = AppColors.flatBluePeterRiver;
  final Color textError = AppColors.redAccent;

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
  final Color appBarBg = AppColors.white;
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

  /// SnackBar
  final Color snackBarHelp = AppColors.flatBluePeterRiver;
  final Color snackBarFailure = AppColors.flatRedAlizarin;
  final Color snackBarSuccess = AppColors.flatGreenEmerald;
  final Color snackBarWarning = AppColors.flatOrangeQuinceJelly;

  /// Shadows
  final Color shadow = AppColors.shadowGrey;
  final Color shadowLighter = AppColors.shadowLightGrey;

  /// Outlines
  final Color outline = AppColors.grey300;
  final Color outlineFocused = AppColors.themeBlue;
  final Color outlineError = AppColors.redAccent;

  /// Splash
  final Color splash = AppColors.themeBlueAlpha10;

  /// Video
  final Color videoBg = AppColors.themeBlue;
  final Color videoProgressIndicator = AppColors.themeYellow;
  final Color videoProgressPlayed = AppColors.themeYellow;
  final Color videoProgressHandle = AppColors.flatYellowSunflower;
  final Color videoItemBg = AppColors.white;
  final Color videoItemSelectedBg = AppColors.themeYellow;
  final Color videoItemIcon = AppColors.themeYellow;
  final Color videoItemText = AppColors.grey900;
  final Color videoItemLock = AppColors.grey600;
  final Color videoItemContentSelected = AppColors.white;
  final Color videoItemContentLocked = AppColors.grey400;

  /// Miscellaneous
  final Color transparent = AppColors.transparent;
  final Color divider = AppColors.grey300;
  final Color price = AppColors.themeBlue;
  final Color strikethroughPrice = AppColors.whiteAlpha60;
  final Color priceBg = AppColors.white;
  final Color widgetCheckBoxSelectedShade = AppColors.flatGreenEmeraldAlpha90;
  final Color contentOnDark = AppColors.white;

  /// const constructor
  const ColorsLightMode();
}
