import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/app_bar/my_platform_app_bar.dart";
import "package:app/components/app_divider.dart";
import "package:app/components/countdown_timer/enums/countdown_timer_state.dart";
import "package:app/components/countdown_timer/notifiers/countdown_timer_notifier.dart";
import "package:app/components/floating_messages/app_dialog/app_dialog.dart";
import "package:app/components/floating_messages/app_dialog/models/app_dialog_button_model.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/pages/quiz/components/quiz_app_bar_bottom.dart";
import "package:app/pages/quiz/components/quiz_questions_list.dart";
import "package:app/pages/quiz/components/quiz_serial_list.dart";
import "package:app/routes.dart";
import "package:flutter/material.dart" show IconButton, Icons, showDialog;
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart" show ReadContext;

class Quiz extends StatefulWidget {
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
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late double timerPanelHeight;

  @override
  void initState() {
    super.initState();
    timerPanelHeight = Res.dimen.iconSizeNormal + Res.dimen.xsSpacingValue * 4;

    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      context.read<CountdownTimerNotifier?>()?.start();
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onCancelQuiz();
      },
      child: PlatformScaffold(
        backgroundColor: Res.color.pageBg,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyPlatformAppBar(
                config: MyAppBarConfig(
                  backgroundColor: Res.color.appBarBgTransparent,
                  shadow: const <BoxShadow>[],
                  title: Text(
                    widget.quiz["title"]! as String,
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
                      onPressed: () => Routes.goBack(context: context),
                    ),
                  ],
                  bottom: QuizAppBarBottom(
                    timerPanelSize: timerPanelHeight,
                    onFinishQuizTap: onFinishQuizTap,
                  ),
                  bottomBorder: AppDivider(
                    margin: EdgeInsets.symmetric(
                      horizontal: Res.dimen.normalSpacingValue,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Res.dimen.normalSpacingValue,
                  ),
                  child: Row(
                    children: <Widget>[
                      QuizSerialList(
                        totalQuestions: widget.questions.length,
                        scrollNotifierId: widget.scrollNotifierId,
                      ),
                      SizedBox.square(
                        dimension: Res.dimen.msSpacingValue,
                      ),
                      Expanded(
                        child: QuizQuestionsList(
                          quiz: widget.quiz,
                          questions: widget.questions,
                          scrollNotifierId: widget.scrollNotifierId,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onCancelQuiz() async {
    CountdownTimerNotifier? timer = context.read<CountdownTimerNotifier?>();
    bool closeQuiz = false;

    if (timer?.state != CountdownTimerState.finished) {
      timer?.pause();

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppDialog(
            title: Res.str.areYouSure,
            message: Res.str.areYouSureToCloseQuiz,
            contentType: ContentType.warning,
            actionButtons: <AppDialogButtonModel>[
              AppDialogButtonModel(
                text: Res.str.no,
                onTap: () {
                  Routes.goBack(context: context);
                  closeQuiz = false;
                },
              ),
              AppDialogButtonModel(
                text: Res.str.yes,
                bgColor: Res.color.buttonHollowBg,
                contentColor: Res.color.buttonHollowContent2,
                onTap: () {
                  Routes.goBack(context: context);
                  closeQuiz = true;
                },
              ),
            ],
          );
        },
      );
    } else {
      closeQuiz = true;
    }

    if (closeQuiz) {
      timer?.stop();
      return true;
    } else {
      timer?.resume();
      return false;
    }
  }

  void onFinishQuizTap() async {
    CountdownTimerNotifier? timer = context.read<CountdownTimerNotifier?>();
    bool finishQuiz = false;

    if (timer?.state != CountdownTimerState.finished) {
      timer?.pause();

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AppDialog(
            title: Res.str.areYouSure,
            message: "Are you sure that you want to finish the quiz?",
            contentType: ContentType.help,
            actionButtons: <AppDialogButtonModel>[
              AppDialogButtonModel(
                text: Res.str.no,
                onTap: () {
                  Routes.goBack(context: context);
                  finishQuiz = false;
                },
              ),
              AppDialogButtonModel(
                text: Res.str.yes,
                // bgColor: Res.color.buttonHollowBg,
                // contentColor: Res.color.buttonHollowContent2,
                onTap: () {
                  Routes.goBack(context: context);
                  finishQuiz = true;
                },
              ),
            ],
          );
        },
      );
    }

    if (finishQuiz) {
      timer?.finishNow();
    } else {
      timer?.resume();
    }
  }
}
