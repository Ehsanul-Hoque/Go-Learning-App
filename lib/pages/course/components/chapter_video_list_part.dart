part of "package:app/pages/course/components/chapter_item.dart";

class ChapterVideoListPart extends StatefulWidget {
  final List<ContentTreeGetResponseContents> contents;

  const ChapterVideoListPart({
    Key? key,
    required this.contents,
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
                  content: item,
                  isSelected: isSelected,
                  isFirst: index == 0,
                  onContentClick: (ContentTreeGetResponseContents content) {
                    bool hasSelected = context
                        .read<CourseContentNotifier>()
                        .selectContent(context, content);

                    if (!hasSelected) {
                      return;
                    }

                    CourseContentType contentType =
                        CourseContentType.valueOf(content.contentType);

                    switch (contentType) {
                      case CourseContentType.lecture:
                        context
                            .read<ContentApiNotifier?>()
                            ?.getLecture(content.sId)
                            .then(onLectureGetComplete);

                        // FIXME Do NOT fire [onLectureGetComplete] method
                        //  in the then clause, rather check if the state
                        //  is still alive and than fire the method
                        break;

                      // TODO handle other types of contents if available

                      case CourseContentType.unknown:
                        break;
                    }
                  },
                );
              },
            );

            return MapEntry<int, Widget>(index, result);
          })
          .values
          .toList(),
    );
  }

  void onLectureGetComplete(NetworkResponse<LectureGetResponse> response) {
    if (!mounted) return;

    if (response.callStatus == NetworkCallStatus.success) {
      context.read<VideoNotifier>().setVideo(
            // "https://player.vimeo.com/video/763095383?h=910b42dfd7",
            // "https://www.youtube.com/watch?v=La0IJPt0t4Q",
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
