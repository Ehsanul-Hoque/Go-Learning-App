import "package:app/components/status_text_widget.dart";
import "package:flutter/widgets.dart";

class StatusText extends StatelessWidget {
  final String text;
  final EdgeInsets? padding;

  const StatusText(
    this.text, {
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusTextWidget(
      text: text,
      padding: padding,
    );
  }
}
