import "package:app/app_config/colors/app_colors.dart";
import "package:app/app_config/resources.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/components/app_container.dart";
import "package:app/components/splash_effect.dart";
import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/pages/course/components/video_item.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:app/utils/typedefs.dart" show OnContentItemClickListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class ChapterItem extends StatefulWidget {
  final CtgrModuleModel chapter;
  final OnContentItemClickListener onContentClick;
  final String? selectedContentId;
  final bool expanded;

  const ChapterItem({
    Key? key,
    required this.chapter,
    required this.onContentClick,
    this.selectedContentId,
    this.expanded = false,
  }) : super(key: key);

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  late List<CtgrContentsModel> _contents;
  late String? _selectedContentId;
  late bool _expanded;

  @override
  void initState() {
    _contents = widget.chapter.contents?.getNonNulls().toList() ??
        <CtgrContentsModel>[];
    _selectedContentId = widget.selectedContentId;
    _expanded = widget.expanded;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChapterItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    // if (widget.selectedContentId != oldWidget.selectedContentId) {
    //   _selectedContentId = widget.selectedContentId;
    // }

    // if (widget.expanded != oldWidget.expanded) {
    //   _expanded = widget.expanded;
    // }
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
                .map((int index, CtgrContentsModel item) {
                  bool isLocked = item.locked ?? true;
                  bool isSelected = (_selectedContentId == item.sId);

                  Widget videoItem = VideoItem(
                    title: item.title ?? "",
                    videoId: "Of8noaoGtJ0", // TODO Get from API
                    isLocked: isLocked,
                    isSelected: isSelected,
                    isFirst: index == 0,
                    onVideoClick: (String videoId, bool isLocked) {
                      widget.onContentClick(
                        "Of8noaoGtJ0", // TODO Get from API
                        isLocked,
                      );
                      if (!isLocked) {
                        setState(() {
                          _selectedContentId = item.sId;
                        });
                      }
                    },
                  );

                  return MapEntry<int, Widget>(index, videoItem);
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
}
