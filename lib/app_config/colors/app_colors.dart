import "package:flutter/material.dart" show Color, Colors;

class AppColors {
  /// Material colors
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color redAccent = Colors.redAccent;
  static const Color transparent = Colors.transparent;

  /// Theme colors and their variations
  static const Color themeBlue = Color(0xff28295B);
  static const Color themeYellow = Color(0xffF8AF3E);
  static const Color themeBlueAlpha10 = Color(0x1a28295B);
  static const Color themeBlueAlpha60 = Color(0x9928295B);
  static const Color themeBlueAlpha90 = Color(0xe628295B);
  static const Color themeYellowAlpha80 = Color(0xccF8AF3E);

  /// Shades of black and grey
  static const Color blackAlpha60 = Color(0x99000000);
  static const Color whiteAlpha60 = Color(0x99ffffff);
  static const Color grey900 = Color(0xff212121);
  static const Color grey850 =
      Color(0xff303030); // only for background color in dark theme
  static const Color grey600 = Color(0xff757575);
  static const Color grey400 = Color(0xffBDBDBD);
  static const Color grey300 = Color(0xffE0E0E0);
  static const Color grey100 = Color(0xffF5F5F5);
  static const Color veryLightGrey = Color(0xffF5F5F5);
  static const Color shadowGrey = Color(0x4d757575);
  static const Color shadowLightGrey = Color(0x4dE0E0E0);

  /// Shades of other colors
  static const Color blueAccent100Alpha50 = Color(0x8082B1FF);
  static const Color green100Alpha50 = Color(0x80C8E6C9);
  static const Color purple100Alpha50 = Color(0x80E1BEE7);

  /// Flat colors
  static const Color flatBlue = Color(0xff74B9FF);
  static const Color flatSunflower = Color(0xffF1C40F);
}
