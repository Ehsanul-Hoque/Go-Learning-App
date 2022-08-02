import "package:flutter/widgets.dart";

class PageViewModel {
  final String title;
  final Widget icon;
  final Widget page;

  const PageViewModel({
    required this.title,
    required this.icon,
    required this.page,
  });
}
