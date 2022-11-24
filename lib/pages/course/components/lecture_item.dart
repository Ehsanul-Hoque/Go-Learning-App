import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/splash_effect.dart";
import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/utils/typedefs.dart" show OnContentItemClickListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class LectureItem extends StatelessWidget {
  final CtgrContentsModel lecture;
  final bool isFirst, isSelected;
  final OnContentItemClickListener onLectureClick;
  final double? leftMargin;

  const LectureItem({
    Key? key,
    required this.lecture,
    required this.isSelected,
    required this.onLectureClick,
    this.isFirst = false,
    this.leftMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLocked = lecture.locked ?? true;

    return AppContainer(
      animated: true,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        top: isFirst ? Res.dimen.smallSpacingValue : Res.dimen.xsSpacingValue,
        left: leftMargin ?? Res.dimen.normalSpacingValue,
      ),
      backgroundColor: isSelected
          ? Res.color.contentItemSelectedBg
          : Res.color.contentItemBg,
      shadow: const <BoxShadow>[],
      child: SplashEffect(
        onTap: () => onLectureClick(lecture),
        child: Padding(
          padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.play_arrow_solid,
                color: isLocked
                    ? Res.color.contentItemContentLocked
                    : isSelected
                        ? Res.color.contentItemContentSelected
                        : Res.color.videoItemIcon,
              ),
              SizedBox(
                width: Res.dimen.normalSpacingValue,
              ),
              Expanded(
                child: Text(
                  lecture.title ?? "",
                  style: Res.textStyles.labelSmall.copyWith(
                    color: isLocked
                        ? Res.color.contentItemContentLocked
                        : isSelected
                            ? Res.color.contentItemContentSelected
                            : Res.color.contentItemText,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              if (isLocked) ...<Widget>[
                SizedBox(
                  width: Res.dimen.normalSpacingValue,
                ),
                Icon(
                  CupertinoIcons.lock_circle,
                  color: isSelected
                      ? Res.color.contentItemContentSelected
                      : Res.color.contentItemLock,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
