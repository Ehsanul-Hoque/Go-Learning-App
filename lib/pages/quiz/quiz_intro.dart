import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/two_line_info.dart";
import "package:app/models/two_line_info_model.dart";
import "package:app/pages/quiz/models/quiz_result_model.dart";
import "package:app/components/advanced_custom_scroll_view/models/acsv_scroll_model.dart";
import "package:app/pages/quiz/quiz.dart";
import "package:app/utils/app_page_nav.dart";
import "package:app/utils/utils.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart"
    show ChangeNotifierProvider, MultiProvider;
import "package:provider/single_child_widget.dart";

class QuizIntro extends StatefulWidget {
  final Map<String, Object> quiz;

  const QuizIntro({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  @override
  State<QuizIntro> createState() => _QuizIntroState();
}

class _QuizIntroState extends State<QuizIntro> {
  late final List<TwoLineInfoModel> _quizInfoItems;

  @override
  void initState() {
    _quizInfoItems = <TwoLineInfoModel>[
      TwoLineInfoModel(
        topText: SampleData.questions.length.toString(), // TODO Get from API
        bottomText: Res.str.questions,
        backgroundColor: Res.color.infoContainerBg1,
      ),
      TwoLineInfoModel(
        topText: Utils.getMmSsFormat(
          Duration(
            milliseconds: widget.quiz["time_millis"]! as int,
          ), // TODO Get from API
        ),
        bottomText: Res.str.minutes,
        backgroundColor: Res.color.infoContainerBg3,
      ),
      TwoLineInfoModel(
        topText:
            "+${(widget.quiz["positive_mark"]! as num).toString()}", // TODO Get from API
        bottomText: Res.str.positiveMarksPerCorrectAns,
        backgroundColor: Res.color.infoContainerBg2,
      ),
      TwoLineInfoModel(
        topText:
            "-${(widget.quiz["negative_mark"]! as num).toString()}", // TODO Get from API
        bottomText: Res.str.negativeMarksPerWrongAns,
        backgroundColor: Res.color.infoContainerBg4,
      ),
      TwoLineInfoModel(
        topText: 0.toString(),
        bottomText: Res.str.marksPerBlankAns,
        backgroundColor: Res.color.infoContainerBg5,
      ),
      TwoLineInfoModel(
        topText:
            "${(widget.quiz["min_percent"]! as num).toString()}%", // TODO Get from API
        bottomText: Res.str.minMarksToPass,
        backgroundColor: Res.color.infoContainerBg6,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                avatarConfig: MyAppBarAvatarConfig.noAvatar(),
                title: Text(
                  widget.quiz["title"]! as String,
                ), // TODO Get title from API
                subtitle: widget.quiz["course_title"]
                    as String?, // TODO Get course title from API
                startActions: <Widget>[
                  IconButton(
                    // TODO extract this back button as a component
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    iconSize: Res.dimen.iconSizeNormal,
                    color: Res.color.iconButton,
                    onPressed: () {
                      PageNav.back(context);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
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
                                children:
                                    _quizInfoItems.map((TwoLineInfoModel item) {
                                  return SizedBox(
                                    width: constraints.maxWidth / 2,
                                    child: TwoLineInfo(
                                      // TODO Get data from API
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
                          borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
                        ),
                      ],
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
    PageNav.to(
      context,
      MultiProvider(
        providers: <SingleChildWidget>[
          ChangeNotifierProvider<AcsvScrollModel>(
            create: (BuildContext context) => AcsvScrollModel(),
          ),
          ChangeNotifierProvider<QuizResultModel>(
            create: (BuildContext context) => QuizResultModel(
              totalQuestions: SampleData.questions.length,
              // TODO Get questions from API
            ),
          ),
        ],
        child: Quiz(
          quiz: widget.quiz,
          questions: SampleData.questions, // TODO Get questions from API
        ),
      ),
    );
  }
}
