import "package:app/app_config/resources.dart";
import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/app_video_player/enums/video_host.dart";
import "package:app/components/app_video_player/notifiers/video_notifier.dart";
import "package:app/components/app_video_player/sub_players/vimeo_video_player.dart";
import "package:app/components/app_video_player/sub_players/youtube_video_player.dart";
import "package:app/components/status_text.dart";
import "package:app/utils/utils.dart";
import "package:flutter/scheduler.dart";
import "package:flutter/services.dart"
    show DeviceOrientation, SystemChrome, SystemUiMode, SystemUiOverlay;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart" show ReadContext;

class AppFullScreenPlayer extends StatefulWidget {
  final AppVideoPlayerConfig config;
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onExitFullScreen;

  const AppFullScreenPlayer({
    Key? key,
    required this.config,
    this.onEnterFullScreen,
    this.onExitFullScreen,
  }) : super(key: key);

  @override
  State<AppFullScreenPlayer> createState() => _AppFullScreenPlayerState();
}

class _AppFullScreenPlayerState extends State<AppFullScreenPlayer>
    with WidgetsBindingObserver {
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final Size physicalSize = SchedulerBinding.instance.window.physicalSize;
    if (physicalSize.width > physicalSize.height) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      isFullScreen = true;
      widget.onEnterFullScreen?.call();
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
      isFullScreen = false;
      widget.onExitFullScreen?.call();
    }

    super.didChangeMetrics();
  }

  @override
  Widget build(BuildContext context) {
    VideoNotifier? videoNotifier = context.read<VideoNotifier?>();
    String videoUrl = videoNotifier?.videoUrl ?? "";
    String videoId = videoNotifier?.videoId ?? "";
    VideoHost videoHost = videoNotifier?.videoHost ?? VideoHost.unknown;
    Widget player;

    switch (videoHost) {
      case VideoHost.vimeo:
        player = VimeoVideoPlayer(
          key: ValueKey<String>("vimeo_video_player_$videoId"),
          config: widget.config,
          videoUrl: videoUrl,
        );
        break;

      case VideoHost.youtube:
        player = YouTubeVideoPlayer(
          key: ValueKey<String>("youtube_video_player_$videoId"),
          config: widget.config,
          videoId: videoId,
        );
        break;

      default:
        if (videoNotifier?.hasSelectedVideo ?? false) {
          player = StatusText(Res.str.generalError);
        } else {
          player = StatusText(Res.str.selectVideoFirst);
        }

        break;
    }

    player = Container(
      key: const ValueKey<String>("app_video_player"),
      child: WillPopScope(
        onWillPop: () async {
          if (isFullScreen) {
            Utils.toggleFullScreenMode(false);
            return false;
          }
          return true;
        },
        child: player,
      ),
    );

    return player;
  }
}
