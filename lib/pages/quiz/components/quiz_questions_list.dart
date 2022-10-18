import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/advanced_custom_scroll_view/acsv_sliver_to_box_adapter.dart";
import "package:app/components/advanced_custom_scroll_view/advanced_custom_scroll_view.dart";
import "package:app/components/advanced_custom_scroll_view/notifiers/acsv_scroll_notifier.dart";
import "package:app/components/app_container.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/countdown_timer/enums/countdown_timer_state.dart";
import "package:app/components/countdown_timer/notifiers/countdown_timer_notifier.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/pages/quiz/components/quiz_mcq.dart";
import "package:app/pages/quiz/notifiers/quiz_result_notifier.dart";
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;
import "package:scroll_to_index/scroll_to_index.dart";

class QuizQuestionsList extends StatefulWidget {
  final Map<String, Object> quiz;
  final List<Map<String, Object>> questions;
  final String scrollNotifierId;

  const QuizQuestionsList({
    Key? key,
    required this.quiz,
    required this.questions,
    required this.scrollNotifierId,
  }) : super(key: key);

  @override
  State<QuizQuestionsList> createState() => _QuizQuestionsListState();
}

class _QuizQuestionsListState extends State<QuizQuestionsList> {
  int currentVisibleQuestion = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Axis axis = (constraints.maxWidth < constraints.maxHeight)
            ? Axis.vertical
            : Axis.horizontal;

        return AdvancedCustomScrollView(
          scrollNotifierId: widget.scrollNotifierId,
          acsvSliversBuilder: (AutoScrollController autoScrollController) {
            List<Widget> questionWidgets = SampleData.questions
                .asMap()
                .map((int index, Map<String, Object> item) {
                  return MapEntry<int, Widget>(
                    index,
                    AcsvSliverToBoxAdapter(
                      key: ValueKey<int>(index),
                      autoScrollTagKey: ValueKey<int>(index),
                      autoScrollController: autoScrollController,
                      autoScrollTagIndex: index,
                      inViewNotifierId: index.toString(),
                      appInViewNotifierWidgetBuilder: (
                        BuildContext context,
                        bool isInView,
                        Widget child,
                      ) {
                        if (isInView) {
                          setCurrentQuestionIndex(context, index);
                        }

                        return child;
                      },
                      borderRadius: Res.dimen.xlBorderRadiusValue,
                      child: Builder(
                        builder: (BuildContext context) {
                          CountdownTimerState timerState = context.select(
                            (CountdownTimerNotifier timer) => timer.state,
                          );

                          int selectedIndex = context.select(
                            (QuizResultNotifier result) =>
                                result.selectedAnswers[index],
                          );

                          int correctIndex = context.select(
                            (QuizResultNotifier result) =>
                                result.correctAnswers[index],
                          );

                          bool hasQuizFinished =
                              (timerState == CountdownTimerState.finished);
                          bool hasAnswered = (selectedIndex >= 0);
                          bool isCorrect = (selectedIndex == correctIndex);

                          Color correctIncorrectColor = hasAnswered
                              ? (isCorrect
                                  ? Res.color.quizCorrectBgLight
                                  : Res.color.quizIncorrectBgLight)
                              : Res.color.quizUnansweredBg;

                          return AppContainer(
                            animated: true,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.all(Res.dimen.msSpacingValue),
                            borderRadius: BorderRadius.circular(
                              Res.dimen.xlBorderRadiusValue,
                            ),
                            backgroundColor: hasQuizFinished
                                ? correctIncorrectColor
                                : Utils.getTransparent(correctIncorrectColor),
                            shadow: const <BoxShadow>[],
                            child: QuizMcq(
                              quesAns: item,
                              onOptionTap: hasQuizFinished
                                  ? null
                                  : (int selectedIndex) {
                                      if (!hasQuizFinished) {
                                        onOptionTap(
                                          context,
                                          index,
                                          selectedIndex,
                                        );
                                      }
                                    },
                              selectedIndex: selectedIndex,
                              correctIndex:
                                  hasQuizFinished ? correctIndex : null,
                              axis: axis,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                })
                .values
                .toList();

            Widget separator = SliverToBoxAdapter(
              child: AppDivider(
                mainAxisSize: constraints.maxWidth /
                    Res.dimen.quizQuesBottomBorderToMaxWidthRatio,
                margin: EdgeInsets.symmetric(
                  vertical: Res.dimen.normalSpacingValue,
                ),
              ),
            );

            int totalWidgets = questionWidgets.length * 2 + 1;

            List<Widget> allWidgets = List<Widget>.generate(
              totalWidgets,
              (int index) {
                if (index == 0 || index == totalWidgets - 1) {
                  return SliverSizedBox(
                    height: Res.dimen.xxlSpacingValue,
                  );
                } else if ((index - 1) % 2 == 0) {
                  return questionWidgets[(index - 1) ~/ 2];
                } else {
                  return separator;
                }
              },
            );

            return allWidgets;
          },
        );
      },
    );
  }

  void onOptionTap(
    BuildContext context,
    int questionIndex,
    int selectedAnswerIndex,
  ) {
    context
        .read<QuizResultNotifier?>()
        ?.setSelectedAnswer(questionIndex, selectedAnswerIndex);

    // TODO Show next unanswered question
  }

  void setCurrentQuestionIndex(BuildContext context, int index) {
    if (currentVisibleQuestion != index) {
      currentVisibleQuestion = index;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Execute callback if page is mounted
        if (!mounted) return;

        context.read<AcsvScrollNotifier?>()?.updateCurrentVisibleIndex(
              notifierId: widget.scrollNotifierId,
              currentVisibleIndex: index,
            );
      });
    }
  }
}
