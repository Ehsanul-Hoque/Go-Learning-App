import 'package:flutter/widgets.dart';

class AppBottomNavigationBarModel {
  Widget icon;
  String text;
  Color? contentInactiveColor, contentActiveColor;
  Color? indicatorColor;

  AppBottomNavigationBarModel({
    required this.icon,
    required this.text,
    this.contentInactiveColor,
    this.contentActiveColor,
    this.indicatorColor,
  });
}
