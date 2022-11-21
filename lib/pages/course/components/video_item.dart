import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/splash_effect.dart";
import "package:app/utils/typedefs.dart" show OnContentItemClickListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class VideoItem extends StatelessWidget {
  final String title, videoId;
  final bool isFirst, isLocked, isSelected;
  final OnContentItemClickListener onVideoClick;
  final double? leftMargin;

  const VideoItem({
    Key? key,
    required this.title,
    required this.videoId,
    required this.isLocked,
    required this.isSelected,
    required this.onVideoClick,
    this.isFirst = false,
    this.leftMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        onTap: () => onVideoClick(videoId, isLocked),
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
                  title,
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
