import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/components/video_item.dart";
import "package:app/utils/typedefs.dart";
import "package:flutter/widgets.dart";

class CoursePlaylist extends StatefulWidget {
  final Map<String, Object> course; // TODO Get data from calling activity
  final String? selectedVideoId;
  final OnVideoItemClickListener onVideoClick;

  const CoursePlaylist({
    Key? key,
    required this.course,
    required this.onVideoClick,
    this.selectedVideoId,
  }) : super(key: key);

  @override
  State<CoursePlaylist> createState() => _CoursePlaylistState();
}

class _CoursePlaylistState extends State<CoursePlaylist>
    with AutomaticKeepAliveClientMixin {
  String? selectedVideoId;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    selectedVideoId = widget.selectedVideoId;
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
      child: CustomScrollView(
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
              isSelected: (selectedVideoId == SampleData.previewVideoId),
              onVideoClick: (String videoId, bool isLocked) {
                widget.onVideoClick(SampleData.previewVideoId, isLocked);
                setState(() {
                  selectedVideoId = SampleData.previewVideoId;
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
              SampleData.videos.map((Map<String, String> item) {
                bool isLocked = (item["locked"] == "true"); // TODO Get from API
                bool isSelected =
                    (selectedVideoId == item["video_id"]); // TODO Get from API

                return VideoItem(
                  title: item["title"]!, // TODO Get from API
                  videoId: item["video_id"]!, // TODO Get from API
                  isLocked: isLocked,
                  isSelected: isSelected,
                  onVideoClick: (String videoId, bool isLocked) {
                    widget.onVideoClick(
                      item["video_id"]!, // TODO Get from API
                      isLocked,
                    );
                    if (!isLocked) {
                      setState(() {
                        selectedVideoId = item["video_id"]; // TODO Get from API
                      });
                    }
                  },
                );
              }).toList(),
            ),
          ),
          SliverSizedBox(
            height: Res.dimen.pageBottomPaddingWithNavBar,
          ),
        ],
      ),
    );
  }
}
