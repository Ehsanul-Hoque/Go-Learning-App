import "package:app/app_config/colors/app_colors.dart";
import "package:app/app_config/resources.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/components/app_container.dart";
import "package:app/components/app_video_player/notifiers/video_notifier.dart";
import "package:app/components/splash_effect.dart";
import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/lecture_get_response.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/pages/course/components/content_item.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

class ChapterItem extends StatefulWidget {
  final ContentTreeGetResponseModule chapter;
  final bool expanded;

  const ChapterItem({
    Key? key,
    required this.chapter,
    this.expanded = false,
  }) : super(key: key);

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  late List<ContentTreeGetResponseContents> _contents;
  late bool _expanded;

  @override
  void initState() {
    _contents = widget.chapter.contents?.getNonNulls().toList() ??
        <ContentTreeGetResponseContents>[];
    _expanded = widget.expanded;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppContainer(
          animated: true,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          backgroundColor: AppColors.white,
          shadow: <BoxShadow>[
            Res.shadows.lighter,
          ],
          child: SplashEffect(
            onTap: onChapterClick,
            child: Padding(
              padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
              child: Row(
                children: <Widget>[
                  const Icon(
                    CupertinoIcons.book_circle,
                    color: AppColors.grey900,
                  ),
                  SizedBox(
                    width: Res.dimen.normalSpacingValue,
                  ),
                  Expanded(
                    child: Text(
                      widget.chapter.title ?? "",
                      style: Res.textStyles.labelSmall.copyWith(
                        color: AppColors.grey900,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  SizedBox(
                    width: Res.dimen.normalSpacingValue,
                  ),
                  AnimatedRotation(
                    duration: Res.durations.defaultDuration,
                    turns: _expanded ? -0.5 : 0,
                    child: const Icon(
                      CupertinoIcons.chevron_down,
                      color: AppColors.grey900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSizeContainer(
          animateForward: _expanded,
          animateOnInit: true,
          axisAlignment: -1,
          axis: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _contents
                .asMap()
                .map((int index, ContentTreeGetResponseContents item) {
                  Widget result = Builder(
                    builder: (BuildContext context) {
                      bool isSelected = context
                          .select((CourseContentNotifier contentNotifier) {
                        String id1 =
                            contentNotifier.selectedContentItem?.sId ?? "x";
                        String id2 = item.sId ?? "y";
                        return id1 == id2;
                      });

                      return ContentItem(
                        content: item,
                        isSelected: isSelected,
                        isFirst: index == 0,
                        onContentClick:
                            (ContentTreeGetResponseContents content) {
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
          ),
        ),
        SizedBox(
          height: Res.dimen.normalSpacingValue,
        ),
      ],
    );
  }

  void onChapterClick() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void onLectureGetComplete(
    NetworkResponse<LectureGetResponse> response,
  ) {
    if (!mounted) return;

    if (response.callStatus == NetworkCallStatus.success) {
      context.read<VideoNotifier>().setVideo(
            // "https://player.vimeo.com/video/763095383?h=910b42dfd7",
            // "https://www.youtube.com/watch?v=La0IJPt0t4Q",
            response.result?.data?.elementAtOrNull(0)?.link ?? "",
          );
    }
  }
}
