import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/splash_effect.dart";
import "package:app/utils/typedefs.dart" show OnVideoItemClickListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class VideoItem extends StatelessWidget {
  final String title, videoId;
  final bool isLocked, isSelected;
  final OnVideoItemClickListener onVideoClick;

  const VideoItem({
    Key? key,
    required this.title,
    required this.videoId,
    required this.isLocked,
    required this.isSelected,
    required this.onVideoClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        bottom: Res.dimen.normalSpacingValue,
      ),
      backgroundColor:
          isSelected ? Res.color.videoItemSelectedBg : Res.color.videoItemBg,
      child: SplashEffect(
        onTap: () => onVideoClick(videoId, isLocked),
        child: Padding(
          padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.play_arrow_solid,
                color: isLocked
                    ? Res.color.videoItemContentLocked
                    : isSelected
                        ? Res.color.videoItemContentSelected
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
                        ? Res.color.videoItemContentLocked
                        : isSelected
                            ? Res.color.videoItemContentSelected
                            : Res.color.videoItemText,
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
                      ? Res.color.videoItemContentSelected
                      : Res.color.videoItemLock,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
