import "package:flutter/material.dart" show MaterialPageRoute;
import "package:flutter/widgets.dart";

class PageNav {
  static void to<T>(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => page,
      ),
    );
  }

  static void replace<T>(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => page,
      ),
    );
  }

  static void back<T>(BuildContext context, {T? result}) {
    Navigator.of(context).maybePop(result);
  }
}
