import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart";

class QuizWorker extends ContentWorker<String> {
  QuizWorker(super.contentItem, super.courseItem);

  @override
  void onTap(BuildContext context, [Map<String, Object?>? args]) {
    CourseGetResponse? course = courseItem;
    if (course != null) {
      Routes().openQuizIntroPage(
        context: context,
        course: course,
        contentWorker: this,
      );
    } else {
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
    }
  }

  @override
  void loadContentData(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]) {
    /*apiNotifier ??= context.read<ContentApiNotifier?>();
    String? contentId = contentItem.sId;

    if (contentId != null && apiNotifier is ContentApiNotifier?) {
      apiNotifier?.getLecture(contentId);
    }*/
  }

  @override
  NetworkCallStatus getResponseCallStatus(
    BuildContext context,
    ApiNotifier? apiNotifier,
  ) {
    /*if (apiNotifier is ContentApiNotifier?) {
      return apiNotifier?.lectureGetResponse(contentItem.sId).callStatus ??
          NetworkCallStatus.none;
    }*/

    return NetworkCallStatus.none;
  }

  @override
  String getResponseObject(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]) {
    /*apiNotifier ??= context.read<ContentApiNotifier?>();

    if (apiNotifier is ContentApiNotifier?) {
      return apiNotifier
              ?.lectureGetResponse(contentItem.sId)
              .result
              ?.data
              ?.elementAtOrNull(0)
              ?.link ??
          "";
    }*/

    return "";
  }
}
