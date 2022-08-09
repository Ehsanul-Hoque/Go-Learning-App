import "package:app/app_config/colors/colors_base.dart";
import "package:app/app_config/colors/colors_light.dart";

enum ColorMode {
  light(ColorsLightMode());

  final ColorsBase colors;

  const ColorMode(this.colors);
}
