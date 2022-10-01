import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/html_text.dart";
import "package:flutter/widgets.dart";

class QuizQuestion extends StatelessWidget {
  final String question;

  const QuizQuestion({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(
        vertical: Res.dimen.hugeSpacingValue,
      ),
      backgroundColor: Res.color.transparent,
      shadow: const <BoxShadow>[],
      child: Center(
        child: HtmlText(
          htmlText: question,
          fontSizeMultiplier: Res.dimen.fontSizeXXXl / Res.dimen.fontSizeNormal,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
