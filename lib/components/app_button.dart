import "package:app/app_config/default_parameters.dart";
import "package:flutter/widgets.dart";

class AppButton extends StatelessWidget {
  final Widget? icon;
  final String text;
  final Color contentColor, backgroundColor;
  final bool tintIconWithContentColor;
  final double borderRadius;
  final Border? border;
  final double minHeight;
  final Function() onTap;

  const AppButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.icon,
    this.contentColor = DefaultParameters.defaultButtonContentColor,
    this.backgroundColor = DefaultParameters.defaultButtonBgColor,
    this.tintIconWithContentColor = true,
    this.borderRadius = DefaultParameters.defaultBorderRadiusValue,
    this.minHeight = DefaultParameters.defaultButtonHeight,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeight,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: DefaultParameters.defaultSmallSpacingValue,
          horizontal: DefaultParameters.defaultNormalSpacingValue,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          color: backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(
                width: DefaultParameters.defaultNormalSpacingValue,
              ),
            ],
            Text(
              text,
              style: DefaultParameters.defaultTextStyle.copyWith(
                color: contentColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
