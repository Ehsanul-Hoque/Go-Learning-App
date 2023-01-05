import "package:app/app_config/resources.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/pages/course/enums/course_content_type.dart";
import "package:app/pages/course/components/chapter_item.dart";
import "package:app/pages/course/components/content_item.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

class CoursePlaylist extends StatefulWidget {
  final CourseGetResponse course;

  const CoursePlaylist({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<CoursePlaylist> createState() => _CoursePlaylistState();
}

class _CoursePlaylistState extends State<CoursePlaylist>
    with AutomaticKeepAliveClientMixin {
  String? courseId;
  List<bool>? expandedChapters;
  late ContentTreeGetResponseContents previewVideoContent;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    previewVideoContent = ContentTreeGetResponseContents(
      contentType: CourseContentType.lecture.name,
      publicToAccess: true, // Because preview video will be available always
      locked: false, // Because preview video will be available always
      title: Res.str.previewVideo,
      link: widget.course.preview ?? "",
      courseId: courseId,
      lectureThumbnail: widget.course.thumbnail,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Execute callback if page is mounted
      if (!mounted) return;

      courseId = widget.course.sId;
      if (courseId != null) {
        context.read<ContentApiNotifier?>()?.getContentTree(courseId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Res.dimen.normalSpacingValue,
      ),
      decoration: const BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: NetworkWidget(
        callStatusSelector: (BuildContext context) => context.select(
          (ContentApiNotifier? apiNotifier) =>
              apiNotifier?.contentTreeGetResponse(courseId).callStatus ??
              NetworkCallStatus.none,
        ),
        statusNoneText: Res.str.invalidCourse,
        childBuilder: (BuildContext context) {
          List<ContentTreeGetResponseModule>? modules = context
              .read<ContentApiNotifier?>()
              ?.contentTreeGetResponse(courseId)
              .result
              ?.module
              ?.getNonNulls()
              .toList();

          List<ContentTreeGetResponseModule> chapters =
              <ContentTreeGetResponseModule>[];

          if (modules != null) {
            for (ContentTreeGetResponseModule item in modules) {
              Iterable<ContentTreeGetResponseModule>? submodules =
                  item.subs?.getNonNulls();
              if (submodules != null) {
                chapters.addAll(submodules);
              }
            }
          }

          return CustomScrollView(
            clipBehavior: Clip.none,
            slivers: <Widget>[
              SliverSizedBox(
                height: Res.dimen.xxlSpacingValue,
              ),
              SliverToBoxAdapter(
                child: Builder(
                  builder: (BuildContext context) {
                    bool isSelected = context.select(
                      (CourseContentNotifier contentNotifier) =>
                          contentNotifier.isPreviewVideoSelected(),
                    );

                    return ContentItem(
                      hasCourseEnrolled: true,
                      // Because preview video will be available always
                      content: previewVideoContent,
                      isSelected: isSelected,
                      leftMargin: 0,
                      onContentClick: onPreviewContentItemClick,
                    );
                  },
                ),
              ),
              SliverSizedBox(
                height: Res.dimen.xxlSpacingValue,
              ),
              SliverToBoxAdapter(
                child: Text(
                  " ${Res.str.courseContents}",
                  style: Res.textStyles.label,
                ),
              ),
              SliverSizedBox(
                height: Res.dimen.normalSpacingValue,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  // Get videos from API
                  List<Widget>.generate(
                    chapters.length,
                    (int index) {
                      ContentTreeGetResponseModule item = chapters[index];

                      return ChapterItem(
                        course: widget.course,
                        chapter: item,
                        expandedList: getExpandedChaptersList(chapters.length),
                        index: index,
                        hasCourseEnrolled: widget.course.hasEnrolled,
                      );
                    },
                  ),
                ),
              ),
              SliverSizedBox(
                height: Res.dimen.pageBottomPaddingWithNavBar,
              ),
            ],
          );
        },
      ),
    );
  }

  List<bool> getExpandedChaptersList(int length) {
    if (expandedChapters == null) {
      expandedChapters = List<bool>.filled(length, false);
      if (expandedChapters!.isNotEmpty) {
        expandedChapters![0] = true;
      }
    }

    return expandedChapters ?? <bool>[];
  }

  void onPreviewContentItemClick(ContentTreeGetResponseContents contentItem) {
    context.read<CourseContentNotifier>().selectPreviewVideo(context);

    CourseContentType contentType =
        CourseContentType.valueOf(contentItem.contentType);
    contentType.workerCreator?.call(widget.course, contentItem).onTap(context);
  }
}
