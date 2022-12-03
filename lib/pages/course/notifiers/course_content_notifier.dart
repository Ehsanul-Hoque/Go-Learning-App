import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:flutter/foundation.dart" show ChangeNotifier;
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class CourseContentNotifier extends ChangeNotifier {
  CourseContentNotifier();

  ContentTreeGetResponseContents? _selectedContentItem;
  YoutubePlayerController? youtubePlayerController;

  ContentTreeGetResponseContents? get selectedContentItem =>
      _selectedContentItem;

  bool selectContent(
    BuildContext context,
    ContentTreeGetResponseContents? contentItem,
  ) {
    if (contentItem?.locked ?? false) {
      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.lockedTitle,
          message: Res.str.lockedDescription,
          contentType: ContentType.help,
        ),
        marginBottom: Res.dimen.snackBarBottomMarginLarge,
      );

      return false;
    }

    // TODO remove/modify this if clause
    //  to make more type of contents accessible
    if (contentItem?.contentType != CourseContentType.lecture.name) {
      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.contentNotAccessibleTitle,
          message: Res.str.contentNotAccessibleDescription,
          contentType: ContentType.help,
        ),
        marginBottom: Res.dimen.snackBarBottomMarginLarge,
      );

      return false;
    }

    _selectedContentItem = contentItem;
    notifyListeners();
    return true;
  }

  bool selectPreviewVideo(BuildContext context) => selectContent(context, null);

  bool isPreviewVideoSelected() => _selectedContentItem == null;

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<CourseContentNotifier>(
        create: (BuildContext context) => CourseContentNotifier(),
      );
}
