import "package:app/app_config/resources.dart";
import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/my_cached_image.dart";
import "package:app/network/network_utils.dart";
import "package:app/utils/typedefs.dart" show VideoPlayerChildBuilder;
import "package:flutter/widgets.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

class YouTubeVideoPlayer extends StatefulWidget {
  final AppVideoPlayerConfig config;
  final VideoPlayerChildBuilder builder;

  const YouTubeVideoPlayer({
    Key? key,
    required this.config,
    required this.builder,
  }) : super(key: key);

  @override
  State<YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<YouTubeVideoPlayer> {
  late final String videoId;
  late final YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    videoId = NetworkUtils.getYouTubeVideoId(widget.config.videoUrl) ?? "";
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        forceHD: true,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Res.color.videoProgressIndicator,
        progressColors: ProgressBarColors(
          playedColor: Res.color.videoProgressPlayed,
          handleColor: Res.color.videoProgressHandle,
        ),
        thumbnail: MyCachedImage(
          imageUrl: widget.config.thumbnail,
          fit: BoxFit.fill,
        ),
      ),
      onEnterFullScreen: () {
        // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      },
      onExitFullScreen: () {
        /*SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: SystemUiOverlay.values,
        );*/
      },
      builder: widget.builder,
    );
  }
}
