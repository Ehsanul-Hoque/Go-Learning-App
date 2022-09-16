import "package:app/app_config/resources.dart";
import "package:flutter/rendering.dart" show Color;

class ContentType {
  static ContentType help = ContentType(Res.color.snackBarHelp);
  static ContentType failure = ContentType(Res.color.snackBarFailure);
  static ContentType success = ContentType(Res.color.snackBarSuccess);
  static ContentType warning = ContentType(Res.color.snackBarWarning);

  final Color color;

  const ContentType(this.color);
}
