import "package:app/app_config/resources.dart";
import "package:app/components/advanced_custom_scroll_view/notifiers/acsv_scroll_notifier.dart";
import "package:app/components/app_container.dart";
import "package:app/components/countdown_timer/enums/countdown_timer_state.dart";
import "package:app/components/countdown_timer/notifiers/countdown_timer_notifier.dart";
import "package:app/pages/quiz/notifiers/quiz_result_notifier.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show Consumer3, ReadContext;

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
    double numberContainerSize = Res.dimen.quizSerialNumberCircleDiameter;
    double paddingBetweenContainerAndBorder = Res.dimen.xxsSpacingValue;
    double borderThickness = Res.dimen.quizCurrentQuesNumBorderThickness;

    double totalSize = numberContainerSize +
        (paddingBetweenContainerAndBorder * 2) +
        (borderThickness * 2);

    return SizedBox(
      width: totalSize,
      child: Consumer3<CountdownTimerNotifier, AcsvScrollNotifier,
          QuizResultNotifier>(
        builder: (
          BuildContext context,
          CountdownTimerNotifier timer,
          AcsvScrollNotifier scroll,
          QuizResultNotifier result,
          Widget? child,
        ) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              int selectedAnswerIndex = result.selectedAnswers[index];
              bool hasAnswered = (selectedAnswerIndex >= 0);
              bool isFirstItem = (index == 0);
              bool isLastItem = (index == (totalQuestions - 1));
              bool isQuestionCurrentlyVisible =
                  (index == scroll.currentVisibleIndex);

              bool hasQuizFinished =
                  (timer.state == CountdownTimerState.finished);
              int correctAnswerIndex = result.correctAnswers[index];
              bool isCorrect = (selectedAnswerIndex == correctAnswerIndex);

              String selectedAnswerAsChar = "";
              if (hasAnswered) {
                selectedAnswerAsChar = String.fromCharCode(
                  Res.str.firstAlphabet.codeUnitAt(0) + selectedAnswerIndex,
                );

                selectedAnswerAsChar = "($selectedAnswerAsChar)";
              }

              return GestureDetector(
                onTap: () => setCurrentQuestionIndex(context, scroll, index),
                child: AppContainer(
                  animated: true,
                  width: totalSize,
                  height: totalSize,
                  shape: BoxShape.circle,
                  backgroundColor: Res.color.transparent,
                  padding: EdgeInsets.all(paddingBetweenContainerAndBorder),
                  margin: EdgeInsets.only(
                    top: isFirstItem ? Res.dimen.hugeSpacingValue : 0,
                    bottom: isLastItem
                        ? Res.dimen.hugeSpacingValue
                        : Res.dimen.msSpacingValue,
                  ),
                  border: isQuestionCurrentlyVisible
                      ? Border.all(
                          color: hasQuizFinished
                              ? (hasAnswered
                                  ? (isCorrect
                                      ? Res.color.quizCorrectBorder
                                      : Res.color.quizIncorrectBorder)
                                  : Res.color.quizUnansweredBorder)
                              : Res.color.quizCurrentBorder,
                          width: borderThickness,
                        )
                      : null,
                  shadow: const <BoxShadow>[],
                  child: Center(
                    child: AppContainer(
                      animated: true,
                      width: numberContainerSize,
                      height: numberContainerSize,
                      shape: BoxShape.circle,
                      backgroundColor: hasQuizFinished
                          ? (hasAnswered
                              ? (isCorrect
                                  ? Res.color.quizCorrectBg
                                  : Res.color.quizIncorrectBg)
                              : Res.color.quizUnansweredBg)
                          : Res.color.quizUnansweredBg,
                      padding: EdgeInsets.symmetric(
                        horizontal: Res.dimen.xsSpacingValue,
                      ),
                      margin: EdgeInsets.zero,
                      shadow: const <BoxShadow>[],
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: Res.dimen.xxsSpacingValue,
                        children: <Widget>[
                          Text(
                            (index + 1).toString(),
                            style: Res.textStyles.buttonBold.copyWith(
                              color: hasAnswered
                                  ? Res.color.quizAnsweredContent
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
                                color: hasAnswered
                                    ? Res.color.quizAnsweredContent
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
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
    AcsvScrollNotifier scroll,
    int index,
  ) {
    if (scroll.currentVisibleIndex != index) {
      context.read<AcsvScrollNotifier?>()?.updateCurrentVisibleIndex(
            notifierId: scrollNotifierId,
            currentVisibleIndex: index,
            updateScrollView: true,
          );
    }
  }
}
