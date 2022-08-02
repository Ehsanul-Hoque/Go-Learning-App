import "package:app/app_config/languages/strings_base.dart";
import "package:app/app_config/languages/strings_en.dart";

enum Language {
  english("en", StringsEn());

  final String isoCode;
  final StringsBase strings;

  const Language(this.isoCode, this.strings);

  static Language valueOf(String isoCode) {
    return Language.values.firstWhere(
      (Language element) => element.isoCode == isoCode,
      orElse: () => Language.english,
    );
  }
}
