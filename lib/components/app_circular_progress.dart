import "package:app/app_config/resources.dart";
import "package:flutter/material.dart" show CircularProgressIndicator;
import "package:flutter/widgets.dart";

class AppCircularProgress extends StatelessWidget {
  final Color? backgroundColor, color;

  const AppCircularProgress({
    Key? key,
    this.backgroundColor,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: backgroundColor ?? Res.color.progressBg,
      color: color ?? Res.color.progress,
    );
  }
}
