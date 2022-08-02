import "package:flutter/widgets.dart";

class AppBottomNavigationBarModel {
  final Widget icon;
  final String text;
  final Color? contentInactiveColor, contentActiveColor;
  final Color? indicatorColor;

  const AppBottomNavigationBarModel({
    required this.icon,
    required this.text,
    this.contentInactiveColor,
    this.contentActiveColor,
    this.indicatorColor,
  });
}
