import "package:app/app_config/default_parameters.dart";
import "package:flutter/widgets.dart";

class AppFormField extends StatelessWidget {
  final String? label, subLabel;
  final Widget appInputField;
  final double topMargin, bottomMargin;

  const AppFormField({
    Key? key,
    this.label,
    this.subLabel,
    required this.appInputField,
    this.topMargin = DefaultParameters.defaultSmallSpacingValue,
    this.bottomMargin = DefaultParameters.defaultSmallSpacingValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: topMargin,
        ),
        if (label != null) ...<Widget>[
          Text(
            label!,
            style: DefaultParameters.labelTextStyle,
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: subLabel != null
                ? DefaultParameters.defaultSmallSpacingValue
                : DefaultParameters.defaultSmallSpacingValue,
          ),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (subLabel != null) ...<Widget>[
              Container(
                height: DefaultParameters.defaultInputFieldHeight,
                padding: const EdgeInsets.only(
                  left: DefaultParameters.defaultMediumSmallSpacingValue,
                  bottom: 2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    subLabel!,
                    style: DefaultParameters.labelTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              const SizedBox(
                width: DefaultParameters.defaultSmallSpacingValue,
              ),
            ],
            Expanded(
              child: appInputField,
            ),
          ],
        ),
        SizedBox(
          height: bottomMargin,
        ),
      ],
    );
  }
}
