import "package:app/app_config/app_state.dart";
import "package:app/app_config/colors/colors_base.dart";
import "package:app/app_config/languages/strings_base.dart";
import "package:flutter/widgets.dart";

part "package:app/app_config/default_params.dart";

class Res {
  const Res();

  static StringsBase get str => AppState.currentLanguage.strings;
  static ColorsBase get color => AppState.currentColorMode.colors;

  static const Dimensions dimen = Dimensions();
  static const TextStyles textStyles = TextStyles();
  static const AnimationParams animParams = AnimationParams();
  static const Shadows shadows = Shadows();
}
