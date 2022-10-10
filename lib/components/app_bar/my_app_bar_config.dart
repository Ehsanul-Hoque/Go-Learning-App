import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class MyAppBarConfig {
  final double toolbarHeight;
  final Color backgroundColor;
  final List<BoxShadow>? shadow;
  final MyAppBarAvatarConfig? avatarConfig;
  final Widget? title;
  final String? subtitle;
  final TextStyle titleStyle, subtitleStyle;
  final bool centerTitle;
  final List<Widget> startActions, endActions;
  final PreferredSizeWidget? bottom;
  final Widget? bottomBorder;
  final Duration animationDuration;
  final Curve animationCurve;

  MyAppBarConfig({
    double? toolbarHeight,
    Color? backgroundColor,
    this.shadow,
    this.avatarConfig,
    this.title,
    this.subtitle,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    this.centerTitle = false,
    List<Widget>? startActions,
    List<Widget>? endActions,
    this.bottom,
    this.bottomBorder,
    Duration? animationDuration,
    Curve? animationCurve,
  })  : toolbarHeight = toolbarHeight ?? Res.dimen.toolbarHeight,
        backgroundColor = backgroundColor ?? Res.color.appBarBg,
        titleStyle = titleStyle ?? Res.textStyles.label,
        subtitleStyle = titleStyle ?? Res.textStyles.subLabel,
        startActions = startActions ?? <Widget>[],
        endActions = endActions ?? <Widget>[],
        animationDuration = animationDuration ?? Res.durations.defaultDuration,
        animationCurve = animationCurve ?? Res.curves.defaultCurve;
}

class MyAppBarAvatarConfig {
  final Color avatarBackgroundColor;
  final double avatarCenterX;
  final double avatarRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  MyAppBarAvatarConfig({
    Color? avatarBackgroundColor,
    double? avatarCenterX,
    double? avatarRadius,
    Duration? animationDuration,
    Curve? animationCurve,
  })  : avatarBackgroundColor =
            avatarBackgroundColor ?? Res.color.appBarAvatarBg,
        avatarCenterX = avatarCenterX ?? Res.dimen.appBarAvatarCenterX,
        avatarRadius = avatarRadius ?? Res.dimen.appBarAvatarRadius,
        animationDuration = animationDuration ?? Res.durations.defaultDuration,
        animationCurve = animationCurve ?? Res.curves.defaultCurve;
}
