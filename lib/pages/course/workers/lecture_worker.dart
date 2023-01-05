import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext;

class LectureWorker extends ContentWorker<String> {
  LectureWorker(super.contentItem, [super.courseItem]);

  @override
  void onTap(BuildContext context, [Map<String, Object?>? args]) {
    Routes().openVideoPage(
      context: context,
      videoConfig: AppVideoPlayerConfig(
        thumbnail: contentItem.lectureThumbnail,
      ),
      url: contentItem.getLectureVideoLink(),
      contentWorker: this,
    );
  }

  @override
  void loadContentData(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]) {
    apiNotifier ??= context.read<ContentApiNotifier?>();
    String? contentId = contentItem.sId;

    if (contentId != null && apiNotifier is ContentApiNotifier?) {
      apiNotifier?.getLecture(contentId);
    }
  }

  @override
  NetworkCallStatus getResponseCallStatus(
    BuildContext context,
    ApiNotifier? apiNotifier,
  ) {
    if (apiNotifier is ContentApiNotifier?) {
      return apiNotifier?.lectureGetResponse(contentItem.sId).callStatus ??
          NetworkCallStatus.none;
    }

    return NetworkCallStatus.none;
  }

  @override
  String getResponseObject(
    BuildContext context, [
    ApiNotifier? apiNotifier,
  ]) {
    apiNotifier ??= context.read<ContentApiNotifier?>();

    if (apiNotifier is ContentApiNotifier?) {
      return apiNotifier
              ?.lectureGetResponse(contentItem.sId)
              .result
              ?.data
              ?.elementAtOrNull(0)
              ?.link ??
          "";
    }

    return "";
  }
}
