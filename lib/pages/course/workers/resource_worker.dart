import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/resource_get_response.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext;

class ResourceWorker extends ContentWorker {
  @override
  void work(BuildContext context, ContentTreeGetResponseContents contentItem) {
    context
        .read<ContentApiNotifier?>()
        ?.getResource(contentItem.sId)
        .then((NetworkResponse<ResourceGetResponse> response) {
      onResourceGetComplete(context, response);
    });

    // FIXME Do NOT fire [onLectureGetComplete] method
    //  in the then clause, rather check if the state
    //  is still alive and than fire the method
  }

  void onResourceGetComplete(
    BuildContext context,
    NetworkResponse<ResourceGetResponse> response,
  ) {
    // if (!mounted) return;

    if (response.callStatus == NetworkCallStatus.success) {
      Routes().openPdfViewerPage(
        context,
        response.result?.data
                ?.elementAtOrNull(0)
                ?.link
                ?.elementAtOrNull(0)
                ?.link ??
            "",
      );
      /*context.read<VideoNotifier>().setVideo(
            response.result?.data?.elementAtOrNull(0)?.link ?? "",
          );

      Routes().openVideoPage(
        context,
        const AppVideoPlayerConfig(),
        null,
        null,
      );*/
    }
  }
}
