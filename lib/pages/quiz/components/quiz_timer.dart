import "dart:math" show max;

import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/countdown_timer/notifiers/countdown_timer_notifier.dart";
import "package:app/utils/utils.dart";
import "package:flutter/material.dart" show Icons;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

part "package:app/pages/quiz/components/quiz_timer_content.dart";

class QuizTimer extends StatelessWidget {
  const QuizTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.all(Res.dimen.xsSpacingValue),
      borderRadius: BorderRadius.circular(
        Res.dimen.fullRoundedBorderRadiusValue,
      ),
      backgroundColor: Res.color.quizTimerBg,
      shadow: const <BoxShadow>[],
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double totalWidth = constraints.maxWidth;
          double totalHeight = constraints.maxHeight;

          return Consumer<CountdownTimerNotifier>(
            builder: (
              BuildContext context,
              CountdownTimerNotifier timer,
              Widget? child,
            ) {
              int timeMillisTotal = timer.totalDuration.inMilliseconds;
              int timeMillisPassed =
                  timer.tickDuration.inMilliseconds * timer.tick;
              double timePercentage = timer.getCurrentProgress();

              double progressWidth = totalWidth * timePercentage;
              double topOrBottom = max((totalHeight - progressWidth) / 2, 0);

              return Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: Res.durations.defaultDuration,
                    left: 0,
                    top: topOrBottom,
                    right: totalWidth - progressWidth,
                    bottom: topOrBottom,
                    child: AppContainer(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(
                        Res.dimen.fullRoundedBorderRadiusValue,
                      ),
                      backgroundColor: Res.color.quizTimerProgress,
                      shadow: const <BoxShadow>[],
                    ),
                  ),
                  QuizTimerContent(
                    timeMillisTotal: timeMillisTotal,
                    timeMillisPassed: timeMillisPassed,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      Res.dimen.fullRoundedBorderRadiusValue,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: timePercentage,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Res.color.contentOnDark,
                          BlendMode.srcATop,
                        ),
                        child: QuizTimerContent(
                          timeMillisTotal: timeMillisTotal,
                          timeMillisPassed: timeMillisPassed,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
