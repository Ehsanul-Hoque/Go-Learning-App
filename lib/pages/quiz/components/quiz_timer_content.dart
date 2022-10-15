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
          Text(
            "$timeMillisPassedText m / $timeMillisTotalText m",
            style: Res.textStyles.labelSmall,
          ),
        ],
      ),
    );
  }
}
