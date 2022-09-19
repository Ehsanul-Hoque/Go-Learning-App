import "package:flutter/widgets.dart";

class TwoLineInfoModel {
  final String topText, bottomText;
  final TextStyle? topTextStyle, bottomTextStyle;
  final Color backgroundColor;

  const TwoLineInfoModel({
    required this.topText,
    required this.bottomText,
    required this.backgroundColor,
    this.topTextStyle,
    this.bottomTextStyle,
  });
}
