import "package:app/app_config/languages/language.dart";
import "package:app/app_config/languages/strings_base.dart";

class AppState {
  AppState._();

  /// Language
  static Language currentLanguage = Language.english;
  static StringsBase get strings => currentLanguage.strings;
}
