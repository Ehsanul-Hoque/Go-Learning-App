import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext;

class QuizWorker extends ContentWorker<QuizAttemptGetResponse> {
  QuizWorker(super.contentItem, super.courseItem);

  @override
  void onTap(BuildContext context, [Map<String, Object?>? args]) {
    bool isError = !contentItem.isAccessibleQuizContent;
    CourseGetResponse? course = courseItem;
    if (course == null) isError = true;

    if (isError) {
      try {
        context.showSnackBar(
          AppSnackBarContent(
            title: Res.str.contentNotAccessibleTitle,
            message: Res.str.contentNotAccessibleDescription,
            contentType: ContentType.help,
          ),
          marginBottom: Res.dimen.snackBarBottomMarginLarge,
        );
      } catch (e, s) {
        Utils.log("", error: e, stackTrace: s);
      }

      return;
    }

    if (course != null) {
      Routes().openQuizIntroPage(
        context: context,
        course: course,
        contentWorker: this,
      );
    }
  }

  @override
  void loadContentData(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]) {
    apiNotifier ??= context.read<ContentApiNotifier?>();
    String? contentId = contentItem.sId;

    if (contentId != null && apiNotifier is ContentApiNotifier?) {
      apiNotifier?.getQuizAttempt(contentId);
    }
  }

  @override
  NetworkCallStatus getResponseCallStatus(
    BuildContext context,
    ApiNotifier? apiNotifier,
  ) {
    if (apiNotifier is ContentApiNotifier?) {
      return apiNotifier?.quizAttemptGetResponse(contentItem.sId).callStatus ??
          NetworkCallStatus.none;
    }

    return NetworkCallStatus.none;
  }

  @override
  QuizAttemptGetResponse? getResponseObject(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]) {
    apiNotifier ??= context.read<ContentApiNotifier?>();
    if (apiNotifier is ContentApiNotifier?) {
      return apiNotifier?.quizAttemptGetResponse(contentItem.sId).result;
    }

    return null;
  }
}
