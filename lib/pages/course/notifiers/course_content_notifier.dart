import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/pages/course/enums/course_content_type.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:flutter/foundation.dart" show ChangeNotifier;
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart";

class CourseContentNotifier extends ChangeNotifier {
  CourseContentNotifier();

  ContentTreeGetResponseContents? _selectedContentItem;
  ContentTreeGetResponseContents? get selectedContentItem =>
      _selectedContentItem;

  bool _isContentSelectable(
    BuildContext context,
    ContentTreeGetResponseContents? contentItem,
    bool hasCourseEnrolled,
  ) {
    bool locked = contentItem?.isActuallyLocked(hasCourseEnrolled) ?? true;

    if (locked) {
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

    CourseContentType contentType =
        CourseContentType.valueOf(contentItem?.contentType);

    if (!contentType.isAvailable) {
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

    return true;
  }

  bool selectContent(
    BuildContext context,
    ContentTreeGetResponseContents? contentItem,
    bool hasCourseEnrolled,
  ) {
    if (!_isContentSelectable(context, contentItem, hasCourseEnrolled)) {
      return false;
    }

    _selectedContentItem = contentItem;
    notifyListeners();
    return true;
  }

  bool selectPreviewVideo(BuildContext context) =>
      selectContent(context, null, true);

  bool isPreviewVideoSelected() => _selectedContentItem == null;

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<CourseContentNotifier>(
        create: (BuildContext context) => CourseContentNotifier(),
      );
}
