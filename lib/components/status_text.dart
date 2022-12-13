import "package:app/app_config/resources.dart";
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
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: Res.dimen.hugeSpacingValue,
          ),
      child: Center(
        child: Text(
          text,
          style: Res.textStyles.secondary,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
