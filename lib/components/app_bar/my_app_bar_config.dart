import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class MyAppBarConfig {
  final double toolbarHeight;
  final Color backgroundColor, avatarBackgroundColor;
  final double avatarCenterX;
  final double avatarRadius;
  final Duration animationDuration;
  final Curve animationCurve;

  MyAppBarConfig({
    double? toolbarHeight,
    Color? backgroundColor,
    Color? avatarBackgroundColor,
    double? avatarCenterX,
    double? avatarRadius,
    Duration? animationDuration,
    Curve? animationCurve,
  })  : toolbarHeight = toolbarHeight ?? Res.dimen.toolbarHeight,
        backgroundColor = backgroundColor ?? Res.color.appBarBg,
        avatarBackgroundColor =
            avatarBackgroundColor ?? Res.color.appBarAvatarBg,
        avatarCenterX = avatarCenterX ?? Res.dimen.appBarAvatarCenterX,
        avatarRadius = avatarRadius ?? Res.dimen.appBarAvatarRadius,
        animationDuration = animationDuration ?? Res.durations.defaultDuration,
        animationCurve = animationCurve ?? Res.curves.defaultCurve;
}
