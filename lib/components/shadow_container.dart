import "package:app/app_config/default_parameters.dart";
import "package:app/utils/app_colors.dart";
import "package:flutter/widgets.dart";

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final double? width, height;
  final EdgeInsets margin, padding;
  final Duration animationDuration;
  final Curve animationCurve;

  const ShadowContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.margin = DefaultParameters.defaultNormalInsetAll,
    this.padding = DefaultParameters.defaultNormalInsetAll,
    this.animationDuration = DefaultParameters.defaultAnimationDuration,
    this.animationCurve = DefaultParameters.defaultAnimationCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: animationCurve,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.none,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: DefaultParameters.defaultBorderRadius,
        boxShadow: <BoxShadow>[
          DefaultParameters.defaultShadow,
        ],
      ),
      child: child,
    );
  }
}
