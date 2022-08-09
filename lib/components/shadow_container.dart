import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final double? width, height;
  final BoxConstraints? constraints;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin, padding;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const ShadowContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.constraints,
    this.borderRadius,
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
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: Res.color.containerBg,
        borderRadius: borderRadius ??
            BorderRadius.circular(Res.dimen.defaultBorderRadiusValue),
        boxShadow: <BoxShadow>[
          Res.shadows.normal,
        ],
      ),
      child: child,
    );
  }
}
