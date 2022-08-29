import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class AppContainer extends StatelessWidget {
  final Widget child;
  final double? width, height;
  final BoxConstraints? constraints;
  final Clip? clip;
  final Color? backgroundColor;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;
  final EdgeInsets? margin, padding;
  final bool animated;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const AppContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.constraints,
    this.clip,
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.shadow,
    this.margin,
    this.padding,
    this.animated = false,
    this.animationDuration,
    this.animationCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (animated) {
      return AnimatedContainer(
        duration: animationDuration ?? Res.durations.defaultDuration,
        curve: animationCurve ?? Res.curves.defaultCurve,
        width: width,
        height: height,
        constraints: constraints,
        margin: margin ?? EdgeInsets.all(Res.dimen.normalSpacingValue),
        padding: padding ?? EdgeInsets.all(Res.dimen.normalSpacingValue),
        clipBehavior: clip ?? Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor ?? Res.color.containerBg,
          border: border,
          borderRadius: borderRadius ??
              BorderRadius.circular(Res.dimen.defaultBorderRadiusValue),
          boxShadow: shadow ??
              <BoxShadow>[
                Res.shadows.normal,
              ],
        ),
        child: child,
      );
    } else {
      return Container(
        width: width,
        height: height,
        constraints: constraints,
        margin: margin ?? EdgeInsets.all(Res.dimen.normalSpacingValue),
        padding: padding ?? EdgeInsets.all(Res.dimen.normalSpacingValue),
        clipBehavior: clip ?? Clip.antiAlias,
        decoration: BoxDecoration(
          color: backgroundColor ?? Res.color.containerBg,
          border: border,
          borderRadius: borderRadius ??
              BorderRadius.circular(Res.dimen.defaultBorderRadiusValue),
          boxShadow: shadow ??
              <BoxShadow>[
                Res.shadows.normal,
              ],
        ),
        child: child,
      );
    }
  }
}
