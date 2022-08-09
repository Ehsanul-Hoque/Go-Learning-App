import "package:app/app_config/colors/color_mode.dart";
import "package:app/app_config/languages/language.dart";

class AppState {
  AppState._();

  static Language currentLanguage = Language.english;
  static ColorMode currentColorMode = ColorMode.light;
}
