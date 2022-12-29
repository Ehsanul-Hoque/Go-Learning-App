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
    String? resourceLink =
        contentItem.getResourceLink()?.elementAtOrNull(0)?.link;

    if (resourceLink != null) {
      return openResourceFile(context, resourceLink);
    }

    context
        .read<ContentApiNotifier?>()
        ?.getResource(contentItem.sId)
        .then((NetworkResponse<ResourceGetResponse> response) {
      onResourceGetComplete(context, response);
    });

    // FIXME Do NOT fire [onResourceGetComplete] method
    //  in the then clause, rather check if the state
    //  is still alive and than fire the method
  }

  void onResourceGetComplete(
    BuildContext context,
    NetworkResponse<ResourceGetResponse> response,
  ) {
    // if (!mounted) return;

    if (response.callStatus == NetworkCallStatus.success) {
      String? resourceLink = response.result?.data
          ?.elementAtOrNull(0)
          ?.link
          ?.elementAtOrNull(0)
          ?.link;

      if (resourceLink != null) {
        return openResourceFile(context, resourceLink);
      }

      // TODO show error that no resource found
    } else {
      // TODO show error that network call failed
    }
  }

  void openResourceFile(BuildContext context, String resourceLink) =>
      Routes().openPdfViewerPage(context, resourceLink);
}
