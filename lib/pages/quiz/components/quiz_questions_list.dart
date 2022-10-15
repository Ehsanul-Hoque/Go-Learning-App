import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/advanced_custom_scroll_view/acsv_sliver_to_box_adapter.dart";
import "package:app/components/advanced_custom_scroll_view/advanced_custom_scroll_view.dart";
import "package:app/components/advanced_custom_scroll_view/notifiers/acsv_scroll_notifier.dart";
import "package:app/pages/quiz/components/quiz_mcq.dart";
import "package:app/pages/quiz/notifiers/quiz_result_notifier.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show Consumer, ReadContext;
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

        return Consumer<QuizResultNotifier>(
          builder: (
            BuildContext context,
            QuizResultNotifier result,
            Widget? child,
          ) {
            return AdvancedCustomScrollView(
              scrollNotifierId: widget.scrollNotifierId,
              acsvSliversBuilder: (AutoScrollController autoScrollController) {
                return SampleData.questions
                    .asMap()
                    .map((int index, Map<String, Object> item) {
                      return MapEntry<int, Widget>(
                        index,
                        AcsvSliverToBoxAdapter(
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
                          child: Padding(
                            padding: EdgeInsets.all(
                              Res.dimen.normalSpacingValue,
                            ),
                            child: QuizMcq(
                              quesAns: item,
                              onOptionTap: (int selectedIndex) {
                                onOptionTap(context, index, selectedIndex);
                              },
                              selectedIndex: result.selectedAnswers[index],
                              axis: axis,
                            ),
                          ),
                        ),
                      );
                    })
                    .values
                    .toList();
              },
            );
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
