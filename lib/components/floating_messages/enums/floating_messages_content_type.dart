import "package:app/app_config/resources.dart";
import "package:flutter/rendering.dart" show Color;

class ContentType {
  static ContentType help = ContentType(
    Res.color.floatingMessagesHelp,
    Res.assets.icHelpSvg,
  );

  static ContentType failure = ContentType(
    Res.color.floatingMessagesFailure,
    Res.assets.icFailureSvg,
  );

  static ContentType success = ContentType(
    Res.color.floatingMessagesSuccess,
    Res.assets.icSuccessSvg,
  );

  static ContentType warning = ContentType(
    Res.color.floatingMessagesWarning,
    Res.assets.icWarningSvg,
  );

  final Color color;
  final String iconAsset;

  const ContentType(this.color, this.iconAsset);
}
