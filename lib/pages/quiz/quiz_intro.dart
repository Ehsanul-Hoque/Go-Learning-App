import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/two_line_info.dart";
import "package:app/models/two_line_info_model.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/routes.dart";
import "package:app/utils/utils.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";

class QuizIntro extends StatefulWidget {
  final CourseGetResponse course;
  final ContentWorker<QuizAttemptGetResponse> contentWorker;

  const QuizIntro({
    Key? key,
    required this.course,
    required this.contentWorker,
  }) : super(key: key);

  @override
  State<QuizIntro> createState() => _QuizIntroState();
}

class _QuizIntroState extends State<QuizIntro> {
  late final List<TwoLineInfoModel> _quizInfoItems;

  @override
  void initState() {
    ContentTreeGetResponseContents contentItem =
        widget.contentWorker.contentItem;
    TextStyle bottomTextStyle = Res.textStyles.smallThick
        .copyWith(color: Res.color.textInfoContainerBottom);

    _quizInfoItems = <TwoLineInfoModel>[
      TwoLineInfoModel(
        topText: contentItem.questions?.length.toString() ?? 0.toString(),
        bottomText: Res.str.questions,
        backgroundColor: Res.color.infoContainerBg1,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: Utils.getMmSsFormat(
          Duration(
            milliseconds: Duration(minutes: contentItem.durationInMinutes ?? 0)
                .inMilliseconds,
          ), // TODO Get from API
        ),
        bottomText: Res.str.minutes,
        backgroundColor: Res.color.infoContainerBg3,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: "+${1.toString()}", // TODO Get from API
        bottomText: Res.str.positiveMarksPerCorrectAns,
        backgroundColor: Res.color.infoContainerBg2,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: "-${(0.25).toString()}", // TODO Get from API
        bottomText: Res.str.negativeMarksPerWrongAns,
        backgroundColor: Res.color.infoContainerBg4,
        bottomTextStyle: bottomTextStyle,
      ),
      TwoLineInfoModel(
        topText: 0.toString(),
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ContentTreeGetResponseContents contentItem =
        widget.contentWorker.contentItem;
    String courseTitle = widget.course.title ?? "";

    return PlatformScaffold(
      backgroundColor: Res.color.pageBg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyPlatformAppBar(
              config: MyAppBarConfig(
                backgroundColor: Res.color.appBarBgTransparent,
                shadow: const <BoxShadow>[],
                title: Text(contentItem.title ?? ""),
                subtitle: courseTitle.isNotEmpty ? Text(courseTitle) : null,
                startActions: <Widget>[
                  IconButton(
                    // TODO extract this back button as a component
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    iconSize: Res.dimen.iconSizeNormal,
                    color: Res.color.iconButton,
                    onPressed: () => Routes.goBack(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
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
                                  children: _quizInfoItems
                                      .map((TwoLineInfoModel item) {
                                    return SizedBox(
                                      width: constraints.maxWidth / 2,
                                      child: TwoLineInfo(
                                        topText: item.topText,
                                        bottomText: item.bottomText,
                                        topTextStyle: item.topTextStyle ??
                                            Res.textStyles.header,
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
                            Res.str.bestOfLuck,
                            style: Res.textStyles.label,
                          ),
                          SizedBox(
                            height: Res.dimen.hugeSpacingValue,
                          ),
                          AppButton(
                            text: Text(Res.str.letsStart),
                            onTap: onStartTap,
                            borderRadius:
                                Res.dimen.fullRoundedBorderRadiusValue,
                          ),
                          SizedBox(
                            height: Res.dimen.hugeSpacingValue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onStartTap() {
    // TODO open quiz page
    /*PageNav.replace(
      context,
      MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<CountdownTimerNotifier>(
            create: (BuildContext context) => CountdownTimerNotifier(
              totalDuration: Duration(
                milliseconds: widget.quiz["time_millis"]! as int,
              ),
              tickDuration: Res.durations.defaultDuration,
            ),
          ),
          ChangeNotifierProvider<AcsvScrollNotifier>(
            create: (BuildContext context) => AcsvScrollNotifier(),
          ),
          ChangeNotifierProvider<QuizResultNotifier>(
            create: (BuildContext context) => QuizResultNotifier(
              correctAnswers:
                  SampleData.questions.map((Map<String, Object> question) {
                return question["correct_index"] as int;
              }).toList(),
              // TODO Get questions from API
            ),
          ),
        ],
        child: Quiz(
          quiz: widget.quiz,
          questions: SampleData.questions, // TODO Get questions from API
        ),
      ),
    );*/
  }
}
