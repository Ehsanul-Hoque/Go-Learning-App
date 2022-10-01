import "package:app/app_config/resources.dart";
import "package:app/pages/quiz/components/quiz_mcq_options.dart";
import "package:app/pages/quiz/components/quiz_question.dart";
import "package:app/utils/typedefs.dart" show OnValueListener;
import "package:flutter/widgets.dart";

class QuizMcq extends StatelessWidget {
  final Map<String, Object> quesAns; // TODO Get from API
  final OnValueListener<int> onOptionTap;
  final Axis axis;
  final int selectedIndex;

  const QuizMcq({
    Key? key,
    required this.quesAns,
    required this.onOptionTap,
    required this.axis,
    this.selectedIndex = -1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IntrinsicHeight(
          child: Flex(
            direction: axis,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (axis == Axis.vertical)
                  ? QuizQuestion(
                      question: quesAns["question"]! as String,
                    )
                  : Expanded(
                      child: QuizQuestion(
                        question: quesAns["question"]! as String,
                      ),
                    ),
              SizedBox.square(
                dimension: Res.dimen.normalSpacingValue,
              ),
              (axis == Axis.vertical)
                  ? QuizMcqOptions(
                      options: quesAns["options"]! as List<String>,
                      onOptionTap: onOptionTap,
                      selectedIndex: selectedIndex,
                    )
                  : Expanded(
                      child: QuizMcqOptions(
                        options: quesAns["options"]! as List<String>,
                        onOptionTap: onOptionTap,
                        selectedIndex: selectedIndex,
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: Res.dimen.xxlSpacingValue,
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth /
                  Res.dimen.quizQuesBottomBorderToMaxWidthRatio,
              height: Res.dimen.defaultBorderThickness,
              color: Res.color.quizQuesAnsBottomBorder,
            );
          },
        ),
      ],
    );
  }
}
