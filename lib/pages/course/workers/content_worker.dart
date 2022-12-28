import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:flutter/widgets.dart";

abstract class ContentWorker {
  void work(BuildContext context, ContentTreeGetResponseContents contentItem);
}
