import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/widgets.dart";

class AppDrawerItemModel {
  final IconData iconData;
  final String text;
  final OnTapListener onTap;
  final bool requireAuth;

  const AppDrawerItemModel({
    required this.iconData,
    required this.text,
    required this.onTap,
    this.requireAuth = false,
  });
}
