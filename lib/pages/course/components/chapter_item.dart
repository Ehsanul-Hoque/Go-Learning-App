import "package:app/app_config/colors/app_colors.dart";
import "package:app/app_config/resources.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/components/app_container.dart";
import "package:app/components/app_video_player/config/app_video_player_config.dart";
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
import "package:app/routes.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext, SelectContext;

part "package:app/pages/course/components/chapter_video_list_part.dart";

class ChapterItem extends StatefulWidget {
  final ContentTreeGetResponseModule chapter;
  final List<bool> expandedList;
  final int index;

  const ChapterItem({
    Key? key,
    required this.chapter,
    required this.expandedList,
    required this.index,
  }) : super(key: key);

  @override
  State<ChapterItem> createState() => _ChapterItemState();
}

class _ChapterItemState extends State<ChapterItem> {
  late List<ContentTreeGetResponseContents> _contents;
  late bool _expanded;
  late bool _firstTime;
  // TODO improve the [_firstTime] bool so the first animation
  //  does not jump to completion, but still scrolls smoothly

  @override
  void initState() {
    _contents = widget.chapter.contents?.getNonNulls().toList() ??
        <ContentTreeGetResponseContents>[];
    _expanded = widget.expandedList.elementAtOrNull(widget.index) == true;
    _firstTime = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Column(
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
                  _firstTime
                      ? RotatedBox(
                          quarterTurns: _expanded ? 2 : 0,
                          child: const Icon(
                            CupertinoIcons.chevron_down,
                            key: ValueKey<String>("chapter_chevron_icon"),
                            color: AppColors.grey900,
                          ),
                        )
                      : AnimatedRotation(
                          duration: Res.durations.defaultDuration,
                          turns: _expanded ? -0.5 : 0,
                          child: const Icon(
                            key: ValueKey<String>("chapter_chevron_icon"),
                            CupertinoIcons.chevron_down,
                            color: AppColors.grey900,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        _firstTime
            ? (_expanded
                ? ChapterVideoListPart(
                    key: const ValueKey<String>("chapter_video_list"),
                    contents: _contents,
                  )
                : const SizedBox.shrink())
            : AnimatedSizeContainer(
                animateForward: _expanded,
                animateOnInit: true,
                axisAlignment: 1,
                axis: Axis.vertical,
                child: ChapterVideoListPart(
                  key: const ValueKey<String>("chapter_video_list"),
                  contents: _contents,
                ),
              ),
        SizedBox(
          height: Res.dimen.normalSpacingValue,
        ),
      ],
    );

    _firstTime = false;

    return result;
  }

  void onChapterClick() {
    setState(() {
      _expanded = !_expanded;

      if ((widget.index >= 0) && (widget.index < widget.expandedList.length)) {
        widget.expandedList[widget.index] = _expanded;
      }
    });
  }
}
