import "package:app/app_config/languages/language.dart";
import "package:app/app_config/languages/strings_base.dart";

class AppState {
  /// Singleton
  factory AppState() => _instance;

  AppState._();
  static final AppState _instance = AppState._();

  /// Language
  Language currentLanguage = Language.english;
  StringsBase get strings => currentLanguage.strings;
}
