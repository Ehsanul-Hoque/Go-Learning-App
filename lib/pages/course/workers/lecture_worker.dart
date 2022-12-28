import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/app_video_player/notifiers/video_notifier.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/lecture_get_response.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext;

class LectureWorker extends ContentWorker {
  @override
  void work(BuildContext context, ContentTreeGetResponseContents contentItem) {
    context
        .read<ContentApiNotifier?>()
        ?.getLecture(contentItem.sId)
        .then((NetworkResponse<LectureGetResponse> response) {
      onLectureGetComplete(context, response);
    });

    // FIXME Do NOT fire [onLectureGetComplete] method
    //  in the then clause, rather check if the state
    //  is still alive and than fire the method
  }

  void onLectureGetComplete(
    BuildContext context,
    NetworkResponse<LectureGetResponse> response,
  ) {
    // if (!mounted) return;

    if (response.callStatus == NetworkCallStatus.success) {
      context.read<VideoNotifier>().setVideo(
            response.result?.data?.elementAtOrNull(0)?.link ?? "",
          );

      Routes().openVideoPage(
        context,
        const AppVideoPlayerConfig(),
        null,
        null,
      );
    }
  }
}
