import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/pages/quiz/components/quiz_questions_list.dart";
import "package:app/pages/quiz/components/quiz_serial_list.dart";
import "package:app/utils/app_page_nav.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";

class Quiz extends StatelessWidget {
  final Map<String, Object> quiz;
  final List<Map<String, Object>> questions;
  final String scrollNotifierId;

  const Quiz({
    Key? key,
    required this.quiz,
    required this.questions,
    this.scrollNotifierId = "1",
  }) : super(key: key);

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
                  quiz["title"]! as String,
                ), // TODO Get title from API
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
              child: Row(
                children: <Widget>[
                  QuizSerialList(
                    totalQuestions: questions.length,
                    scrollNotifierId: scrollNotifierId,
                  ),
                  Expanded(
                    child: QuizQuestionsList(
                      quiz: quiz,
                      questions: questions,
                      scrollNotifierId: scrollNotifierId,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
