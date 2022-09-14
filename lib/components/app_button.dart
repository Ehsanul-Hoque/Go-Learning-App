import "package:app/app_config/resources.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/widgets.dart";

class AppButton extends StatelessWidget {
  final Widget? icon;
  final Widget text;
  final Color? contentColor, backgroundColor;
  final bool tintIconWithContentColor;
  final bool alignCenter;
  final double? borderRadius;
  final Border? border;
  final double? minHeight;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? spaceBetweenIconAndText;
  final OnTapListener onTap;

  const AppButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.icon,
    this.contentColor,
    this.backgroundColor,
    this.tintIconWithContentColor = true,
    this.alignCenter = true,
    this.borderRadius,
    this.minHeight,
    this.border,
    this.padding,
    this.fontSize,
    this.spaceBetweenIconAndText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color contentColor = this.contentColor ?? Res.color.buttonFilledContent;
    Color backgroundColor = this.backgroundColor ?? Res.color.buttonFilledBg;
    double borderRadius =
        this.borderRadius ?? Res.dimen.defaultBorderRadiusValue;
    double minHeight = this.minHeight ?? Res.dimen.buttonHeight;
    double spaceBetweenIconAndText =
        this.spaceBetweenIconAndText ?? Res.dimen.normalSpacingValue;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeight,
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: Res.dimen.smallSpacingValue,
              horizontal: Res.dimen.normalSpacingValue,
            ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment:
              alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            if (icon != null) ...<Widget>[
              tintIconWithContentColor
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        contentColor,
                        BlendMode.srcATop,
                      ),
                      child: icon!,
                    )
                  : icon!,
              SizedBox(
                width: spaceBetweenIconAndText,
              ),
            ],
            DefaultTextStyle(
              style: Res.textStyles.button.copyWith(
                color: contentColor,
                fontSize: fontSize ?? Res.dimen.fontSizeNormal,
              ),
              textAlign: (icon != null) ? TextAlign.start : TextAlign.center,
              child: text,
            ),
          ],
        ),
      ),
    );
  }
}
