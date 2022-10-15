import "dart:ui" show Color;

import "package:app/utils/typedefs.dart" show OnTapListener;

class AppDialogButtonModel {
  final String text;
  final OnTapListener onTap;
  final Color? bgColor, contentColor;

  const AppDialogButtonModel({
    required this.text,
    required this.onTap,
    this.bgColor,
    this.contentColor,
  });
}
