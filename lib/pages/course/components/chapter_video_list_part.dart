part of "package:app/pages/course/components/chapter_item.dart";

class ChapterVideoListPart extends StatefulWidget {
  final List<ContentTreeGetResponseContents> contents;
  final bool hasCourseEnrolled;

  const ChapterVideoListPart({
    Key? key,
    required this.contents,
    required this.hasCourseEnrolled,
  }) : super(key: key);

  @override
  State<ChapterVideoListPart> createState() => _ChapterVideoListPartState();
}

class _ChapterVideoListPartState extends State<ChapterVideoListPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.contents
          .asMap()
          .map((int index, ContentTreeGetResponseContents item) {
            Widget result = Builder(
              builder: (BuildContext context) {
                bool isSelected =
                    context.select((CourseContentNotifier contentNotifier) {
                  String id1 = contentNotifier.selectedContentItem?.sId ?? "x";
                  String id2 = item.sId ?? "y";
                  return id1 == id2;
                });

                return ContentItem(
                  hasCourseEnrolled: widget.hasCourseEnrolled,
                  content: item,
                  isSelected: isSelected,
                  isFirst: index == 0,
                  onContentClick: onContentItemClick,
                );
              },
            );

            return MapEntry<int, Widget>(index, result);
          })
          .values
          .toList(),
    );
  }

  void onContentItemClick(ContentTreeGetResponseContents contentItem) {
    bool hasSelected = context
        .read<CourseContentNotifier>()
        .selectContent(context, contentItem, widget.hasCourseEnrolled);

    if (!hasSelected) {
      return;
    }

    CourseContentType contentType =
        CourseContentType.valueOf(contentItem.contentType);

    contentType.worker?.work(context, contentItem);
  }
}
