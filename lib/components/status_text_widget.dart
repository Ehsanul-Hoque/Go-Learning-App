import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class StatusTextWidget extends StatelessWidget {
  final Widget? child;
  final String? text;
  final EdgeInsets? padding;

  const StatusTextWidget({
    Key? key,
    this.child,
    this.text,
    this.padding,
  })  : assert(
          (child != null) || (text != null),
          "Both child and text cannot be null at the same time.",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            vertical: Res.dimen.hugeSpacingValue,
          ),
      child: Center(
        child: DefaultTextStyle(
          style: Res.textStyles.secondary,
          textAlign: TextAlign.center,
          child: child ?? Text(text ?? ""),
        ),
      ),
    );
  }
}
