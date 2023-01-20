import "package:app/app_config/resources.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/routes.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/widgets.dart";

class MyAppBarConfig {
  final double toolbarHeight;
  final Color backgroundColor;
  final List<BoxShadow>? shadow;
  final MyAppBarAvatarConfig? avatarConfig;
  final Widget? title, subtitle;
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
  final OnTapListener onAvatarTap;

  MyAppBarAvatarConfig({
    required BuildContext context,
    Color? avatarBackgroundColor,
    double? avatarCenterX,
    double? avatarRadius,
    Duration? animationDuration,
    Curve? animationCurve,
    OnTapListener? onAvatarTap,
  })  : avatarBackgroundColor =
            avatarBackgroundColor ?? Res.color.appBarAvatarBg,
        avatarCenterX = avatarCenterX ?? Res.dimen.appBarAvatarCenterX,
        avatarRadius = avatarRadius ?? Res.dimen.appBarAvatarRadius,
        animationDuration = animationDuration ?? Res.durations.defaultDuration,
        animationCurve = animationCurve ?? Res.curves.defaultCurve,
        onAvatarTap = onAvatarTap ?? (() => _defaultAvatarTapListener(context));

  static void _defaultAvatarTapListener(BuildContext context) {
    if (UserBox.isLoggedIn) {
      Routes().openUserProfilePage(context);
    } else {
      Routes().openAuthPage(
        context: context,
        redirectOnSuccess: (BuildContext context) =>
            Routes(config: const RoutesConfig(replace: true))
                .openUserProfilePage(context),
      );
    }
  }
}
