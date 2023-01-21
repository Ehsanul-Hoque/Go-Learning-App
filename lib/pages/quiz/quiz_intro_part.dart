part of "package:app/pages/quiz/quiz_intro.dart";

class QuizIntroPart extends StatelessWidget {
  final ContentTreeGetResponseContents contentItem;
  final QuizAttemptGetResponse bestQuizAttemptResponse;
  final OnTapListener onButtonTap;

  late final List<TwoLineInfoModel> quizInfoItems;
  late final bool alreadyAttemptedQuiz;

  QuizIntroPart({
    Key? key,
    required this.contentItem,
    required this.bestQuizAttemptResponse,
    required this.onButtonTap,
  }) : super(key: key) {
    TextStyle bottomTextStyle = Res.textStyles.smallThick
        .copyWith(color: Res.color.textInfoContainerBottom);

    QuizAttemptGetResponseData? prevAttemptData = bestQuizAttemptResponse.data;
    Iterable<QuizAttemptGetResponseQuestion>? prevAttemptQuestions =
        prevAttemptData?.questions?.getNonNulls();

    int totalQuestions = contentItem.questions?.getNonNulls().length ??
        prevAttemptQuestions?.length ??
        0;
    int totalSeconds = (contentItem.durationInMinutes ??
            prevAttemptData?.durationInMinutes ??
            QuizConstants.defaultDurationInMinutes) *
        Duration.secondsPerMinute;
    double positiveMarksPerAns = prevAttemptQuestions?.firstOrNull?.mark ??
        QuizConstants.defaultPositiveMarksPerAns;
    double negativeMarksPerAns =
        prevAttemptQuestions?.firstOrNull?.negativeMark ??
            QuizConstants.defaultNegativeMarksPerAns;
    double marksPerBlankAns = QuizConstants.defaultMarksPerBlankAns;

    bool unlimitedTime = (totalSeconds <= 0);

    quizInfoItems = <TwoLineInfoModel>[
      TwoLineInfoModel(
        topText: totalQuestions.toString(),
        bottomText: Res.str.questions,
        backgroundColor: Res.color.infoContainerBg1,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: unlimitedTime
            ? Res.str.unlimited
            : Utils.getMmSsFormat(
                Duration(
                  milliseconds: Duration(seconds: totalSeconds).inMilliseconds,
                ),
              ),
        bottomText: unlimitedTime ? Res.str.time : Res.str.minutes,
        backgroundColor: Res.color.infoContainerBg3,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: "+${positiveMarksPerAns.getCompactString(2)}",
        bottomText: Res.str.positiveMarksPerCorrectAns,
        backgroundColor: Res.color.infoContainerBg2,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: "-${negativeMarksPerAns.getCompactString(2)}",
        bottomText: Res.str.negativeMarksPerWrongAns,
        backgroundColor: Res.color.infoContainerBg4,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: marksPerBlankAns.getCompactString(2),
        bottomText: Res.str.marksPerBlankAns,
        backgroundColor: Res.color.infoContainerBg5,
        bottomTextStyle: bottomTextStyle,
      ),
      /*TwoLineInfoModel(
        topText: "${80.toString()}%", // TODO Get from API
        bottomText: Res.str.minMarksToPass,
        backgroundColor: Res.color.infoContainerBg6,
        bottomTextStyle: bottomTextStyle,
      )*/
    ];

    alreadyAttemptedQuiz = bestQuizAttemptResponse.data != null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Res.dimen.maxWidthNormal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  Res.str.instructions,
                  style: Res.textStyles.label,
                ),
                SizedBox(
                  height: Res.dimen.normalSpacingValue,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: Res.dimen.maxWidthSmall,
                  ),
                  child: LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints constraints,
                    ) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        children: quizInfoItems.map((TwoLineInfoModel item) {
                          return SizedBox(
                            width: constraints.maxWidth / 2,
                            child: TwoLineInfo(
                              topText: item.topText,
                              bottomText: item.bottomText,
                              topTextStyle:
                                  item.topTextStyle ?? Res.textStyles.header,
                              bottomTextStyle: item.bottomTextStyle,
                              backgroundColor: item.backgroundColor,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Res.dimen.hugeSpacingValue,
                ),
                Text(
                  "${Res.str.lastBestScoreColon} "
                  "${bestQuizAttemptResponse.data?.totalScore?.toStringAsFixed(2) ?? Res.str.none}",
                  style: Res.textStyles.label,
                ),
                SizedBox(
                  height: Res.dimen.largeSpacingValue,
                ),
                Text(
                  Res.str.bestOfLuck,
                  style: Res.textStyles.label,
                ),
                SizedBox(
                  height: Res.dimen.hugeSpacingValue,
                ),
                AppButton(
                  text: Text(Res.str.letsStart),
                  onTap: onButtonTap,
                  borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
                ),
                SizedBox(
                  height: Res.dimen.hugeSpacingValue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
