import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class IconAndText extends StatelessWidget {
  final Widget? iconWidget;
  final IconData? iconData;
  final String text;
  final TextStyle? textStyle;

  const IconAndText({
    Key? key,
    this.iconWidget,
    this.iconData,
    required this.text,
    this.textStyle,
  })  : assert(iconWidget != null || iconData != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        iconWidget ??
            Icon(
              iconData,
              size: Res.dimen.iconSizeXxs,
              color: Res.color.textSecondary,
            ),
        SizedBox(
          width: Res.dimen.xxsSpacingValue,
        ),
        Text(
          text,
          style: textStyle ?? Res.textStyles.small,
        ),
      ],
    );
  }
}
