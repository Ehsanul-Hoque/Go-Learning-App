import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:flutter/material.dart"
    show
        BuildContext,
        Clip,
        Colors,
        ScaffoldMessenger,
        SnackBar,
        SnackBarBehavior;

extension ContextExtension on BuildContext {
  void showSnackBar(AppSnackBarContent content) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        clipBehavior: Clip.none,
        backgroundColor: Colors.transparent,
        content: content,
      ),
    );
  }
}
