import "package:app/app_config/colors/color_mode.dart";
import "package:app/app_config/languages/language.dart";
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart" show GlobalKey, NavigatorState;

class AppState {
  AppState._();

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Language currentLanguage = Language.english;
  static ColorMode currentColorMode = ColorMode.light;
  static String _currentSessionKey = "";

  static String get currentSessionKey => _currentSessionKey;
  static void generateNewSessionKey() {
    _currentSessionKey = Utils.getRandomString(20);
    Utils.log("|-----------------------------------------------------------|");
    Utils.log("|      New session key generated: $_currentSessionKey      |");
    Utils.log("|-----------------------------------------------------------|");
  }

  static bool isValidSessionKey(String sessionKeyToCheck) =>
      sessionKeyToCheck == currentSessionKey;
}
