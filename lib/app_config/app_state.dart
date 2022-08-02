import "package:app/app_config/languages/language.dart";
import "package:app/app_config/languages/strings_base.dart";

class AppState {
  /// Language
  Language currentLanguage = Language.english;
  StringsBase get strings => currentLanguage.strings;
}
