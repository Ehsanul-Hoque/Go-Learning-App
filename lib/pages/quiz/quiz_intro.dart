import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_button.dart";
import "package:app/components/status_text.dart";
import "package:app/components/two_line_info.dart";
import "package:app/models/two_line_info_model.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/pages/quiz/constants/quiz_constants.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:app/utils/typedefs.dart";
import "package:app/utils/utils.dart";
import "package:collection/collection.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart";

part "package:app/pages/quiz/quiz_intro_part.dart";

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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      widget.contentWorker.loadContentData(context);
    });
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
              child: NetworkWidget(
                callStatusSelector: (BuildContext context) {
                  return context.select(
                    (ContentApiNotifier? apiNotifier) => widget.contentWorker
                        .getResponseCallStatus(context, apiNotifier),
                  );
                },
                childBuilder: (BuildContext context) {
                  QuizAttemptGetResponse? bestQuizAttemptResponse =
                      widget.contentWorker.getResponseObject(context);

                  if (bestQuizAttemptResponse != null) {
                    return QuizIntroPart(
                      contentItem: widget.contentWorker.contentItem,
                      bestQuizAttemptResponse: bestQuizAttemptResponse,
                      onButtonTap: () => onStartTap(
                        widget.contentWorker.contentItem,
                        bestQuizAttemptResponse,
                      ),
                    );
                  }

                  return StatusText(Res.str.generalError);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onStartTap(
    ContentTreeGetResponseContents quizContent,
    QuizAttemptGetResponse previousBestAttempt,
  ) {
    Routes().openQuizPage(
      context: context,
      course: widget.course,
      quizContent: quizContent,
      previousBestAttempt: previousBestAttempt,
    );
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
