import "package:app/network/enums/network_call_status.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/routes.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext;

class ResourceWorker extends ContentWorker<String> {
  ResourceWorker(super.contentItem, [super.courseItem]);

  @override
  void onTap(BuildContext context, [Map<String, Object?>? args]) {
    Routes().openPdfViewerPage(
      context: context,
      url: contentItem.getResourceLink()?.elementAtOrNull(0)?.link,
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
      apiNotifier?.getResource(contentId);
    }
  }

  @override
  NetworkCallStatus getResponseCallStatus(
    BuildContext context,
    ApiNotifier? apiNotifier,
  ) {
    if (apiNotifier is ContentApiNotifier?) {
      return apiNotifier?.resourceGetResponse(contentItem.sId).callStatus ??
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
              ?.resourceGetResponse(contentItem.sId)
              .result
              ?.data
              ?.elementAtOrNull(0)
              ?.link
              ?.elementAtOrNull(0)
              ?.link ??
          "";
    }

    return "";
  }
}
