import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/pages/quiz/models/quiz_result_model.dart";
import "package:app/components/advanced_custom_scroll_view/models/acsv_scroll_model.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show Consumer2, ReadContext;

class QuizSerialList extends StatelessWidget {
  final int totalQuestions;
  final String scrollNotifierId;

  const QuizSerialList({
    Key? key,
    required this.totalQuestions,
    required this.scrollNotifierId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      child: Consumer2<AcsvScrollModel, QuizResultModel>(
        builder: (
          BuildContext context,
          AcsvScrollModel scroll,
          QuizResultModel result,
          Widget? child,
        ) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              int selectedAnswerIndex = result.selectedAnswers[index];
              bool isAnswered = (selectedAnswerIndex >= 0);
              bool isLastItem = (index == (totalQuestions - 1));
              bool isQuestionCurrentlyVisible =
                  (index == scroll.currentVisibleIndex);

              String selectedAnswerAsChar = "";
              if (isAnswered) {
                selectedAnswerAsChar = String.fromCharCode(
                  Res.str.firstAlphabet.codeUnitAt(0) + selectedAnswerIndex,
                );

                selectedAnswerAsChar = "($selectedAnswerAsChar)";
              }

              return GestureDetector(
                onTap: () => setCurrentQuestionIndex(context, scroll, index),
                child: AppContainer(
                  animated: true,
                  shape: BoxShape.circle,
                  backgroundColor: Res.color.transparent,
                  padding: EdgeInsets.all(Res.dimen.xxsSpacingValue),
                  margin: EdgeInsets.only(
                    bottom: isLastItem ? 0 : Res.dimen.msSpacingValue,
                  ),
                  border: isQuestionCurrentlyVisible
                      ? Border.all(
                          color: Res.color.quizCurrentQuesNumBorder,
                          width: Res.dimen.quizCurrentQuesNumBorderThickness,
                        )
                      : null,
                  shadow: const <BoxShadow>[],
                  child: AppContainer(
                    animated: true,
                    shape: BoxShape.circle,
                    backgroundColor: isAnswered
                        ? Res.color.quizAnsweredQuesNumBg
                        : Res.color.quizUnansweredQuesNumBg,
                    padding: EdgeInsets.all(Res.dimen.msSpacingValue),
                    margin: EdgeInsets.zero,
                    shadow: const <BoxShadow>[],
                    child: Row(
                      children: <Widget>[
                        const Spacer(),
                        Text(
                          (index + 1).toString(),
                          style: Res.textStyles.buttonBold.copyWith(
                            color: isAnswered
                                ? Res.color.quizAnsweredQuesNum
                                : null,
                          ),
                        ),
                        AnimatedSize(
                          duration: Res.durations.defaultDuration,
                          curve: Res.curves.defaultCurve,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedAnswerAsChar,
                            style: Res.textStyles.buttonBold.copyWith(
                              color: isAnswered
                                  ? Res.color.quizAnsweredQuesNum
                                  : null,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: totalQuestions,
            shrinkWrap: true,
          );
        },
      ),
    );
  }

  void setCurrentQuestionIndex(
    BuildContext context,
    AcsvScrollModel scroll,
    int index,
  ) {
    if (scroll.currentVisibleIndex != index) {
      context.read<AcsvScrollModel?>()?.updateCurrentVisibleIndex(
            notifierId: scrollNotifierId,
            currentVisibleIndex: index,
            updateScrollView: true,
          );
    }
  }
}
