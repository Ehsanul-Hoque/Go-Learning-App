// ignore_for_file: annotate_overrides

import "dart:ui";

import "package:app/app_config/colors/colors_base.dart";
import "package:app/app_config/colors/app_colors.dart";

class ColorsLightMode implements ColorsBase {
  /// Page
  final Color pageBg = AppColors.veryLightGrey;

  /// Containers
  final Color containerBg = AppColors.white;

  /// Texts
  final Color textPrimary = AppColors.grey900;
  final Color textSecondary = AppColors.grey600;
  final Color textTernary = AppColors.grey400;
  final Color textLink = AppColors.flatBlue;
  final Color textError = AppColors.redAccent;

  /// Input fields
  final Color inputFieldBg = AppColors.transparent;

  /// Buttons
  final Color buttonFilledBg = AppColors.themeYellowAlpha80;
  final Color buttonFilledContent = AppColors.white;
  final Color buttonHollowBg = AppColors.transparent;
  final Color buttonHollowBorder = AppColors.grey300;
  final Color buttonHollowContent = AppColors.black;
  final Color iconButton = AppColors.black;
  final Color secondaryIconButton = AppColors.grey600;

  /// Tabs
  final Color tabIndicatorBg = AppColors.grey300;
  final Color tabIndicator = AppColors.themeBlue;
  final Color tabLabel = AppColors.themeBlueAlpha60;
  final Color tabSelectedLabel = AppColors.themeBlue;

  /// App Bar
  final Color appBarBg = AppColors.white;
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

  /// Shadows
  final Color shadow = AppColors.shadowGrey;
  final Color shadowLighter = AppColors.shadowLightGrey;

  /// Outlines
  final Color outline = AppColors.grey300;
  final Color outlineFocused = AppColors.themeBlue;
  final Color outlineError = AppColors.redAccent;

  /// Miscellaneous
  final Color divider = AppColors.grey300;
  final Color priceColor = AppColors.themeBlue;
  final Color priceBgColor = AppColors.white;

  /// const constructor
  const ColorsLightMode();
}
