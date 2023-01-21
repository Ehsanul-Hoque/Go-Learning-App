part of "package:app/pages/quiz/components/quiz_timer.dart";

class QuizTimerContent extends StatelessWidget {
  final int timeMillisTotal, timeMillisPassed;

  const QuizTimerContent({
    Key? key,
    required this.timeMillisTotal,
    required this.timeMillisPassed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timeMillisTotalText = Utils.getMmSsFormat(
      Duration(milliseconds: timeMillisTotal),
    );
    String timeMillisPassedText = Utils.getMmSsFormat(
      Duration(milliseconds: timeMillisPassed),
    );
    String m = Res.str.minutesVeryShort;

    return Padding(
      padding: EdgeInsets.all(Res.dimen.xsSpacingValue),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: Res.dimen.smallSpacingValue,
          ),
          Icon(
            Icons.timer_outlined,
            size: Res.dimen.iconSizeNormal,
            color: Res.color.iconButton,
          ),
          SizedBox(
            width: Res.dimen.smallSpacingValue,
          ),
          QuizStateBuilder(
            prevAttemptBuilder: (BuildContext context) {
              return Text(
                "$timeMillisTotalText $m",
                style: Res.textStyles.labelSmall,
              );
            },
            currentAttemptBuilder: (BuildContext context) {
              return Text(
                "$timeMillisPassedText $m / $timeMillisTotalText $m",
                style: Res.textStyles.labelSmall,
              );
            },
          ),
        ],
      ),
    );
  }
}
