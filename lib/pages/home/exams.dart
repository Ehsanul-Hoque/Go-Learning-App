import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/debouncer.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/components/quiz_item.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:flutter/widgets.dart";

class Exams extends StatefulWidget {
  const Exams({Key? key}) : super(key: key);

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Debouncer(
      child: ListView(
        padding: EdgeInsets.only(
          left: Res.dimen.normalSpacingValue,
          top: Res.dimen.getPageTopPaddingWithAppBar(context),
          right: Res.dimen.normalSpacingValue,
          bottom: Res.dimen.pageBottomPaddingWithNavBar,
        ),
        children: SampleData.quizzes.map((Map<String, Object> item) {
          // TODO Get quizzes from API
          return QuizItem(
            title: item["title"]! as String, // TODO Get from API
            quizId: item["id"]! as String, // TODO Get from API
            isLocked: item["locked"]! as bool, // TODO Get from API
            onQuizClick: onQuizClick,
          );
        }).toList(),
      ),
    );
  }

  void onQuizClick(ContentTreeGetResponseContents content) {
    if (content.locked ?? false) {
      context.showSnackBar(
        AppSnackBarContent(
          title: "Locked!",
          message: "This item is locked right now.",
          contentType: ContentType.help,
        ),
      );
    } else {
      // TODO open quiz intro page
      /*PageNav.to(
        context,
        QuizIntro(
          quiz: SampleData.quizzes.firstWhere((Map<String, Object> element) {
            return element["id"] == content.sId;
          }),
        ),
      );*/
    }
  }
}
