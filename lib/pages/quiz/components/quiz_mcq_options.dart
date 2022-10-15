import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/html_text.dart";
import "package:app/components/splash_effect.dart";
import "package:app/utils/typedefs.dart";
import "package:flutter/widgets.dart";

class QuizMcqOptions extends StatelessWidget {
  final List<String> options;
  final int selectedIndex;
  final OnValueListener<int> onOptionTap;

  const QuizMcqOptions({
    Key? key,
    required this.options,
    required this.onOptionTap,
    this.selectedIndex = -1,
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
                backgroundColor: isSelected
                    ? Res.color.quizAnsweredQuesBg
                    : Res.color.quizUnansweredQuesBg,
                shadow: const <BoxShadow>[],
                child: SplashEffect(
                  onTap: () => onOptionTap(index),
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
                        color: isSelected ? Res.color.quizAnsweredQues : null,
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
