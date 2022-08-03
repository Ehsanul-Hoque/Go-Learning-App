import "package:app/app_config/default_parameters.dart";
import "package:app/utils/app_colors.dart";
import "package:flutter/widgets.dart";

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final double? width, height;
  final bool enableMargin, enablePadding;

  const ShadowContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.enableMargin = true,
    this.enablePadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: enableMargin
          ? DefaultParameters.defaultNormalInsetAll
          : EdgeInsets.zero,
      padding: enablePadding
          ? DefaultParameters.defaultNormalInsetAll
          : EdgeInsets.zero,
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
