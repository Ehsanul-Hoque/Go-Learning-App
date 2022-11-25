import "package:app/app_config/resources.dart";
import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/app_video_player/sub_players/vimeo_video_player.dart";
import "package:app/components/app_video_player/sub_players/youtube_video_player.dart";
import "package:app/components/status_text.dart";
import "package:app/network/network_utils.dart";
import "package:app/utils/typedefs.dart" show VideoPlayerChildBuilder;
import "package:flutter/widgets.dart";

class AppVideoPlayerBuilder extends StatelessWidget {
  final AppVideoPlayerConfig config;
  final VideoPlayerChildBuilder builder;

  const AppVideoPlayerBuilder({
    Key? key,
    required this.builder,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (NetworkUtils.isYouTubeUrl(config.videoUrl)) {
      return YouTubeVideoPlayer(config: config, builder: builder);
    }

    if (NetworkUtils.isVimeoUrl(config.videoUrl)) {
      return VimeoVideoPlayer(config: config, builder: builder);
    }

    return StatusText(Res.str.generalError);
  }
}
