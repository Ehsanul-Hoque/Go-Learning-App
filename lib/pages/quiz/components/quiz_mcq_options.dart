import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/app_html/html_text.dart";
import "package:app/components/splash_effect.dart";
import "package:app/utils/typedefs.dart";
import "package:flutter/widgets.dart";

class QuizMcqOptions extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final int? correctIndex;
  final OnValueListener<int>? onOptionTap;

  const QuizMcqOptions({
    Key? key,
    required this.options,
    required this.onOptionTap,
    this.selectedIndex = -1,
    this.correctIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: options
          .asMap()
          .map((int index, String item) {
            bool lastItem = (index == options.length - 1);
            bool isSelected = (index == selectedIndex);
            bool isCorrect = (index == correctIndex);
            bool hasQuizFinished = (correctIndex != null);

            MapEntry<int, Widget> mapEntry = MapEntry<int, Widget>(
              index,
              AppContainer(
                animated: true,
                margin: lastItem
                    ? EdgeInsets.zero
                    : EdgeInsets.only(bottom: Res.dimen.normalSpacingValue),
                padding: EdgeInsets.zero,
                borderRadius:
                    BorderRadius.circular(Res.dimen.largeBorderRadiusValue),
                backgroundColor: hasQuizFinished
                    ? (isCorrect
                        ? Res.color.quizCorrectBg
                        : (isSelected
                            ? Res.color.quizIncorrectBg
                            : Res.color.quizUnansweredBg2))
                    : (isSelected
                        ? Res.color.quizAnsweredBg
                        : Res.color.quizUnansweredBg),
                shadow: const <BoxShadow>[],
                child: SplashEffect(
                  onTap:
                      (onOptionTap != null) ? () => onOptionTap!(index) : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Res.dimen.smallSpacingValue,
                      horizontal: Res.dimen.normalSpacingValue,
                    ),
                    child: HtmlText(
                      htmlText: item,
                      fontSizeMultiplier:
                          Res.dimen.fontSizeMedium / Res.dimen.fontSizeNormal,
                      textAlign: TextAlign.center,
                      defaultTextStyle: Res.textStyles.general.copyWith(
                        color: (isSelected || (hasQuizFinished && isCorrect))
                            ? Res.color.quizAnsweredContent
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            );

            return mapEntry;
          })
          .values
          .toList(),
    );
  }
}
