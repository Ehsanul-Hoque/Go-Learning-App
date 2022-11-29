import "package:app/app_config/resources.dart";
import "package:app/components/app_video_player/notifiers/video_notifier.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/pages/course/components/chapter_item.dart";
import "package:app/pages/course/components/content_item.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/pages/course/notifiers/course_content_notifier.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

class CoursePlaylist extends StatefulWidget {
  final CourseGetResponseModel course;

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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

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
          List<CtgrModuleModel>? modules = context
              .read<ContentApiNotifier?>()
              ?.contentTreeGetResponse(courseId)
              .result
              ?.module
              ?.getNonNulls()
              .toList();

          List<CtgrModuleModel> chapters = <CtgrModuleModel>[];

          if (modules != null) {
            for (CtgrModuleModel item in modules) {
              Iterable<CtgrModuleModel>? submodules = item.subs?.getNonNulls();
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
                      content: CtgrContentsModel(
                        contentType: CourseContentType.lecture,
                        publicToAccess: true,
                        locked: false,
                        title: Res.str.previewVideo,
                        courseId: courseId,
                      ),
                      isSelected: isSelected,
                      leftMargin: 0,
                      onContentClick: (CtgrContentsModel lecture) {
                        context
                            .read<CourseContentNotifier>()
                            .selectPreviewVideo(context);

                        context
                            .read<VideoNotifier>()
                            .setVideo(widget.course.preview ?? "");
                      },
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
                      CtgrModuleModel item = chapters[index];

                      return ChapterItem(
                        chapter: item,
                        expanded: index == 0,
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
}
