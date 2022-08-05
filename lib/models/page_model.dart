import "package:flutter/widgets.dart";

class PageModel {
  final String title;
  final Widget icon;
  final Widget page;
  final Map<String, Object?> configs;

  const PageModel({
    required this.title,
    Widget? icon,
    Widget? page,
    this.configs = const <String, Object?>{},
  })  : icon = icon ?? const SizedBox.shrink(),
        page = page ?? const SizedBox.shrink();
}
