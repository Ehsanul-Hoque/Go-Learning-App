import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:flutter/widgets.dart";

class TwoLineInfo extends StatelessWidget {
  final String topText, bottomText;
  final TextStyle? topTextStyle, bottomTextStyle;
  final Color? backgroundColor;

  const TwoLineInfo({
    Key? key,
    required this.topText,
    required this.bottomText,
    this.topTextStyle,
    this.bottomTextStyle,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: EdgeInsets.all(Res.dimen.smallSpacingValue),
      padding: EdgeInsets.symmetric(
        vertical: Res.dimen.normalSpacingValue,
        horizontal: Res.dimen.xsSpacingValue,
      ),
      backgroundColor: backgroundColor,
      shadow: const <BoxShadow>[],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            topText,
            style: topTextStyle ?? Res.textStyles.label,
            textAlign: TextAlign.center,
          ),
          Text(
            bottomText,
            style: bottomTextStyle ?? Res.textStyles.smallThick,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
