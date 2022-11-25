import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/network/network_utils.dart";
import "package:app/utils/typedefs.dart" show VideoPlayerChildBuilder;
import "package:flutter/widgets.dart";
import "package:vimeo_player_flutter/vimeo_player_flutter.dart";

class VimeoVideoPlayer extends StatefulWidget {
  final AppVideoPlayerConfig config;
  final VideoPlayerChildBuilder builder;

  const VimeoVideoPlayer({
    Key? key,
    required this.config,
    required this.builder,
  }) : super(key: key);

  @override
  State<VimeoVideoPlayer> createState() => _VimeoVideoPlayerState();
}

class _VimeoVideoPlayerState extends State<VimeoVideoPlayer> {
  late final String videoId;

  @override
  void initState() {
    videoId = NetworkUtils.getVimeoVideoId(widget.config.videoUrl) ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      VimeoPlayer(
        videoId: videoId,
      ),
    );
  }
}
