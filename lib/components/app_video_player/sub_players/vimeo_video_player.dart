import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:flutter/widgets.dart";
import "package:vimeo_player_flutter/vimeo_player_flutter.dart";

class VimeoVideoPlayer extends StatelessWidget {
  final AppVideoPlayerConfig config;
  final String videoId;

  const VimeoVideoPlayer({
    Key? key,
    required this.config,
    required this.videoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VimeoPlayer(
      videoId: videoId,
    );
  }
}
