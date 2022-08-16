import "package:app/app_config/resources.dart";
import "package:app/components/fields/app_input_base_widget.dart";
import "package:flutter/widgets.dart";

class AppFormField extends StatelessWidget {
  final String? label, subLabel;
  final TextStyle? labelTextStyle, subLabelTextStyle;
  final AppInputBaseWidget appInputField;
  final EdgeInsets? margin, labelMargin, subLabelMargin;

  const AppFormField({
    Key? key,
    this.label,
    this.labelTextStyle,
    this.subLabel,
    this.subLabelTextStyle,
    required this.appInputField,
    this.margin,
    this.labelMargin,
    this.subLabelMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ??
          EdgeInsets.symmetric(
            vertical: Res.dimen.smallSpacingValue,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label != null)
            Padding(
              padding: labelMargin ??
                  EdgeInsets.only(
                    bottom: Res.dimen.smallSpacingValue,
                  ),
              child: Text(
                label!,
                style: labelTextStyle ?? Res.textStyles.secondary,
                textAlign: TextAlign.start,
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (subLabel != null)
                Container(
                  height: Res.dimen.inputFieldHeight,
                  padding: subLabelMargin ??
                      EdgeInsets.only(
                        left: Res.dimen.msSpacingValue,
                        right: Res.dimen.smallSpacingValue,
                        bottom: 2,
                      ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      subLabel!,
                      style: subLabelTextStyle ?? Res.textStyles.secondary,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              Expanded(
                child: appInputField as Widget,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
