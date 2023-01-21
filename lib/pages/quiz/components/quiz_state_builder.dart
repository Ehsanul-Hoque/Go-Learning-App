import "package:app/app_config/resources.dart";
import "package:app/components/status_text.dart";
import "package:app/pages/quiz/enums/quiz_state.dart";
import "package:app/pages/quiz/notifiers/quiz_notifier.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show SelectContext;

typedef ChildBuilder = Widget Function(BuildContext context);

class QuizStateBuilder extends StatelessWidget {
  final ChildBuilder? prevAttemptBuilder;
  final ChildBuilder? currentAttemptBuilder;
  final ChildBuilder? resultBuilder;

  const QuizStateBuilder({
    Key? key,
    this.prevAttemptBuilder,
    this.currentAttemptBuilder,
    this.resultBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        QuizState? quizState = context
            .select((QuizNotifier? apiNotifier) => apiNotifier?.currentState);

        Widget widget;

        switch (quizState) {
          case QuizState.previousAttempt:
            widget = prevAttemptBuilder?.call(context) ??
                StatusText(Res.str.quizStateNotHandled);
            break;

          case QuizState.currentAttempt:
            widget = currentAttemptBuilder?.call(context) ??
                StatusText(Res.str.quizStateNotHandled);

            break;
          case QuizState.result:
            widget = resultBuilder?.call(context) ??
                currentAttemptBuilder?.call(context) ??
                StatusText(Res.str.quizStateNotHandled);
            break;

          case null:
            widget = StatusText(Res.str.quizStateNotHandled);
            break;
        }

        widget = AnimatedSize(
          duration: Res.durations.defaultDuration,
          curve: Res.curves.defaultCurve,
          alignment: Alignment.topCenter,
          child: widget,
        );

        return AnimatedSwitcher(
          duration: Res.durations.defaultDuration,
          switchInCurve: Res.curves.defaultCurve,
          switchOutCurve: Res.curves.defaultCurve,
          child: widget,
        );
      },
    );
  }
}
