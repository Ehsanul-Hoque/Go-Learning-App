import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart";

abstract class ContentWorker<T> {
  CourseGetResponse? courseItem;
  ContentTreeGetResponseContents contentItem;

  ContentWorker(this.contentItem, [this.courseItem]);

  void onTap(BuildContext context, [Map<String, Object?>? args]);

  void loadContentData(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]);

  NetworkCallStatus getResponseCallStatus(
    BuildContext context,
    ApiNotifier? apiNotifier,
  );

  T? getResponseObject(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]);
}
