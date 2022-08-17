import "dart:ui";

import "package:app/app_config/colors/app_colors.dart";

abstract class ColorsBase {
  /// Page
  final Color pageBg = AppColors.transparent;

  /// Containers
  final Color containerBg = AppColors.transparent;

  /// Texts
  final Color textPrimary = AppColors.transparent;
  final Color textSecondary = AppColors.transparent;
  final Color textTernary = AppColors.transparent;
  final Color textLink = AppColors.transparent;
  final Color textError = AppColors.transparent;

  /// Input fields
  final Color inputFieldBg = AppColors.transparent;

  /// Buttons
  final Color buttonFilledBg = AppColors.transparent;
  final Color buttonFilledContent = AppColors.transparent;
  final Color buttonHollowBg = AppColors.transparent;
  final Color buttonHollowBorder = AppColors.transparent;
  final Color buttonHollowContent = AppColors.transparent;
  final Color iconButton = AppColors.transparent;
  final Color secondaryIconButton = AppColors.transparent;

  /// Tabs
  final Color tabIndicatorBg = AppColors.transparent;
  final Color tabIndicator = AppColors.transparent;
  final Color tabLabel = AppColors.transparent;
  final Color tabSelectedLabel = AppColors.transparent;

  /// App Bar
  final Color appBarBg = AppColors.transparent;
  final Color appBarAvatarBg = AppColors.transparent;

  /// Bottom Navigation
  final Color bottomNavBg = AppColors.transparent;
  final Color bottomNavIndicator = AppColors.transparent;
  final Color bottomNavItemBg = AppColors.transparent;
  final Color bottomNavItemActive = AppColors.transparent;
  final Color bottomNavItemInactive = AppColors.transparent;

  /// Carousal Indicator
  final Color carousalIndicator = AppColors.transparent;
  final Color carousalIndicatorActive = AppColors.transparent;

  /// Shadows
  final Color shadow = AppColors.transparent;
  final Color shadowLighter = AppColors.transparent;

  /// Outlines
  final Color outline = AppColors.transparent;
  final Color outlineFocused = AppColors.transparent;
  final Color outlineError = AppColors.transparent;

  /// Miscellaneous
  final Color divider = AppColors.transparent;
  final Color priceColor = AppColors.transparent;
  final Color priceBgColor = AppColors.transparent;

  /// Private const constructor
  const ColorsBase._();
}
