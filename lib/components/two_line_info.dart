import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:flutter/widgets.dart";

class TwoLineInfo extends StatelessWidget {
  final String topText, bottomText;
  final Color? backgroundColor;

  const TwoLineInfo({
    Key? key,
    required this.topText,
    required this.bottomText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: EdgeInsets.all(Res.dimen.smallSpacingValue),
      backgroundColor: backgroundColor,
      shadow: const <BoxShadow>[],
      child: Column(
        children: <Widget>[
          Text(
            topText,
            style: Res.textStyles.label,
            textAlign: TextAlign.center,
          ),
          Text(
            bottomText,
            style: Res.textStyles.smallThick,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
