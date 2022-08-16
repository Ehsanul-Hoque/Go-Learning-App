import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class AppContainer extends StatelessWidget {
  final Widget child;
  final double? width, height;
  final BoxConstraints? constraints;
  final Clip? clip;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;
  final EdgeInsets? margin, padding;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const AppContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.constraints,
    this.clip,
    this.border,
    this.borderRadius,
    this.shadow,
    this.margin,
    this.padding,
    this.animationDuration,
    this.animationCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration ?? Res.animParams.defaultDuration,
      curve: animationCurve ?? Res.animParams.defaultCurve,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin ?? EdgeInsets.all(Res.dimen.normalSpacingValue),
      padding: padding ?? EdgeInsets.all(Res.dimen.normalSpacingValue),
      clipBehavior: clip ?? Clip.antiAlias,
      decoration: BoxDecoration(
        color: Res.color.containerBg,
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
