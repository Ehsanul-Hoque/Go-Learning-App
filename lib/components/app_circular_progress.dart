import "package:app/app_config/resources.dart";
import "package:flutter/material.dart" show CircularProgressIndicator;
import "package:flutter/widgets.dart";

class AppCircularProgress extends StatelessWidget {
  final double? dimension, thickness;
  final Color? backgroundColor, color;

  const AppCircularProgress({
    Key? key,
    this.dimension,
    this.thickness,
    this.backgroundColor,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor ?? Res.color.progressBg,
        color: color ?? Res.color.progress,
        strokeWidth: thickness ?? Res.dimen.circularProgressDefaultThickness,
      ),
    );
  }
}
