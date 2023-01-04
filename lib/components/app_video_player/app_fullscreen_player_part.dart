part of "package:app/components/app_video_player/app_fullscreen_player.dart";

class AppFullScreenPlayerPart extends StatelessWidget {
  final AppVideoPlayerConfig config;
  final bool isFullScreen;
  final String url;

  const AppFullScreenPlayerPart({
    Key? key,
    required this.config,
    required this.isFullScreen,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isValidUrl = url.trim().isNotEmpty;
    if (!isValidUrl) return StatusText(Res.str.generalError);

    Widget player =
        VideoHostType.getHostFromUrl(url).getPlayer?.call(url, config) ??
            StatusText(Res.str.generalError);

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
