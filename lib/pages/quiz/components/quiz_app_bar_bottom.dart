import "package:app/app_config/resources.dart";
import "package:app/components/app_button.dart";
import "package:app/components/countdown_timer/enums/countdown_timer_state.dart";
import "package:app/components/countdown_timer/notifiers/countdown_timer_notifier.dart";
import "package:app/pages/quiz/components/quiz_timer.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

class QuizAppBarBottom extends StatelessWidget implements PreferredSizeWidget {
  final double timerPanelSize;
  final OnTapListener onFinishQuizTap;

  const QuizAppBarBottom({
    Key? key,
    required this.timerPanelSize,
    required this.onFinishQuizTap,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(timerPanelSize + Res.dimen.xsSpacingValue);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: timerPanelSize,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Res.dimen.normalSpacingValue,
          ),
          const Expanded(
            child: QuizTimer(),
          ),
          SizedBox(
            width: Res.dimen.smallSpacingValue,
          ),
          AnimatedSize(
            duration: Res.durations.defaultDuration,
            curve: Res.curves.defaultCurve,
            child: Builder(
              builder: (BuildContext context) {
                CountdownTimerState timerState = context.select(
                  (CountdownTimerNotifier timer) => timer.state,
                );

                return AnimatedSwitcher(
                  duration: Res.durations.defaultDuration,
                  switchInCurve: Res.curves.defaultCurve,
                  switchOutCurve: Res.curves.defaultCurve,
                  child: (timerState == CountdownTimerState.finished)
                      ? Text(
                          Res.str.quizFinished,
                          key: const ValueKey<bool>(true),
                          style: Res.textStyles.ternary,
                        )
                      : AppButton(
                          key: const ValueKey<bool>(false),
                          text: Text(Res.str.finishQuiz),
                          onTap: onFinishQuizTap,
                          minHeight: timerPanelSize,
                          padding: EdgeInsets.symmetric(
                            horizontal: Res.dimen.normalSpacingValue,
                          ),
                          backgroundColor: Res.color.buttonFilledBg,
                          contentColor: Res.color.buttonFilledContent,
                          tintIconWithContentColor: false,
                          borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
                        ),
                );
              },
            ),
          ),
          SizedBox(
            width: Res.dimen.normalSpacingValue,
          ),
        ],
      ),
    );
  }
}
