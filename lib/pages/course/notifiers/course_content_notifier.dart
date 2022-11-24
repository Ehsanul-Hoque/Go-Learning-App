import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/utils.dart";
import "package:flutter/foundation.dart" show ChangeNotifier;
import "package:flutter/widgets.dart" show BuildContext;
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class CourseContentNotifier extends ChangeNotifier {
  late final String _previewVideoLink;
  CtgrContentsModel? _selectedContentItem;
  YoutubePlayerController? youtubePlayerController;

  CtgrContentsModel? get selectedContentItem => _selectedContentItem;

  CourseContentNotifier({
    required String previewVideoLink,
  }) : _previewVideoLink = previewVideoLink;

  void selectContent(BuildContext context, CtgrContentsModel? contentItem) {
    if (contentItem?.locked ?? false) {
      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.lockedTitle,
          message: Res.str.lockedDescription,
          contentType: ContentType.help,
        ),
        marginBottom: Res.dimen.snackBarBottomMarginLarge,
      );

      return;
    }

    _selectedContentItem = contentItem;

    if (contentItem != null &&
        contentItem.contentType == CourseContentType.lecture) {
      // _youtubePlayerController.load(videoId);
      Utils.log("Playing lecture via controller [1] => ${contentItem.sId}");
    }

    notifyListeners();
  }

  void selectPreviewVideo(BuildContext context) => selectContent(context, null);

  bool isPreviewVideoSelected() => _selectedContentItem == null;
}
