import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:flutter/material.dart"
    show
        BuildContext,
        Clip,
        EdgeInsets,
        ScaffoldMessenger,
        SnackBar,
        SnackBarBehavior;

extension ContextExtension on BuildContext {
  void showSnackBar(AppSnackBarContent content, {double? marginBottom}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        margin: EdgeInsets.fromLTRB(
          15,
          5,
          15,
          marginBottom ?? Res.dimen.snackBarBottomMargin,
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        clipBehavior: Clip.none,
        backgroundColor: Res.color.transparent,
        content: content,
      ),
    );
  }
}
