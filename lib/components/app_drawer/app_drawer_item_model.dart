import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/widgets.dart";

class AppDrawerItemModel {
  final IconData iconData;
  final String text;
  final OnTapListener onTap;

  const AppDrawerItemModel({
    required this.iconData,
    required this.text,
    required this.onTap,
  });
}
