import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/pages/course/components/chapter_item.dart";
import "package:app/pages/course/components/video_item.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:app/utils/typedefs.dart" show OnContentItemClickListener;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

class CoursePlaylist extends StatefulWidget {
  final CourseGetResponseModel course;
  final String? selectedContentId;
  final OnContentItemClickListener onContentClick;

  const CoursePlaylist({
    Key? key,
    required this.course,
    required this.onContentClick,
    this.selectedContentId,
  }) : super(key: key);

  @override
  State<CoursePlaylist> createState() => _CoursePlaylistState();
}

class _CoursePlaylistState extends State<CoursePlaylist>
    with AutomaticKeepAliveClientMixin {
  String? selectedContentId;
  String? courseId;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    selectedContentId = widget.selectedContentId;

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
                child: VideoItem(
                  title: Res.str.previewVideo,
                  videoId: SampleData.previewVideoId,
                  isLocked: false,
                  isSelected: (selectedContentId == SampleData.previewVideoId),
                  leftMargin: 0,
                  onVideoClick: (String videoId, bool isLocked) {
                    widget.onContentClick(SampleData.previewVideoId, isLocked);
                    setState(() {
                      selectedContentId = SampleData.previewVideoId;
                    });
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
                        onContentClick: (String videoId, bool isLocked) {
                          widget.onContentClick(videoId, isLocked);
                          if (!isLocked) {
                            setState(() {
                              selectedContentId = videoId;
                            });
                          }
                        },
                        selectedContentId: selectedContentId,
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
