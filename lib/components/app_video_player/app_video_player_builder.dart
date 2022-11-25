import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/app_video_player/sub_players/vimeo_video_player.dart";
import "package:app/components/app_video_player/sub_players/youtube_video_player.dart";
import "package:app/components/status_text.dart";
import "package:app/network/network_utils.dart";
import "package:app/utils/app_page_nav.dart";
import "package:app/utils/typedefs.dart" show VideoPlayerChildBuilder;
import "package:app/utils/utils.dart";
import "package:flutter/material.dart" show IconButton, Icons;
import "package:flutter/scheduler.dart";
import "package:flutter/services.dart"
    show SystemChrome, SystemUiMode, SystemUiOverlay;
import "package:flutter/widgets.dart";

class AppVideoPlayerBuilder extends StatefulWidget {
  final AppVideoPlayerConfig config;
  final VideoPlayerChildBuilder builder;
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onExitFullScreen;

  const AppVideoPlayerBuilder({
    Key? key,
    required this.builder,
    required this.config,
    this.onEnterFullScreen,
    this.onExitFullScreen,
  }) : super(key: key);

  @override
  State<AppVideoPlayerBuilder> createState() => _AppVideoPlayerBuilderState();
}

class _AppVideoPlayerBuilderState extends State<AppVideoPlayerBuilder>
    with WidgetsBindingObserver {
  bool isFullScreen = false;

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
    Widget player;

    if (NetworkUtils.isYouTubeUrl(widget.config.videoUrl)) {
      player = YouTubeVideoPlayer(config: widget.config);
    } else if (NetworkUtils.isVimeoUrl(widget.config.videoUrl)) {
      player = VimeoVideoPlayer(config: widget.config);
    } else {
      player = StatusText(Res.str.generalError);
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

    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return widget.builder(context, player);
        }

        return Row(
          children: <Widget>[
            AppContainer(
              width: Res.dimen.toolbarHeight,
              height: double.infinity,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.only(
                top: Res.dimen.smallSpacingValue,
                bottom: Res.dimen.smallSpacingValue,
              ),
              borderRadius: BorderRadius.zero,
              shadow: const <BoxShadow>[],
              backgroundColor: Res.color.containerDarkBg,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    // TODO extract this back button as a component
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    iconSize: Res.dimen.iconSizeNormal,
                    color: Res.color.contentOnDark,
                    onPressed: () {
                      PageNav.back(context);
                    },
                  ),
                  IconButton(
                    // TODO extract this fullscreen button as a component
                    // (button for app bar - something like that)
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.fullscreen_exit_rounded,
                    ),
                    iconSize: Res.dimen.iconSizeNormal,
                    color: Res.color.contentOnDark,
                    onPressed: () {
                      Utils.toggleFullScreenMode(false);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: player,
            ),
          ],
        );
      },
    );
  }
}
