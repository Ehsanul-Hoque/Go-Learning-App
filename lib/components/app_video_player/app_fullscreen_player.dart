import "package:app/app_config/resources.dart";
import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/app_video_player/enums/video_host_type.dart";
import "package:app/components/status_text.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/utils/utils.dart";
import "package:flutter/scheduler.dart";
import "package:flutter/services.dart"
    show DeviceOrientation, SystemChrome, SystemUiMode, SystemUiOverlay;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

part "package:app/components/app_video_player/app_fullscreen_player_part.dart";

class AppFullScreenPlayer extends StatefulWidget {
  final AppVideoPlayerConfig config;
  final String? url;
  final ContentWorker<String>? contentWorker;
  final VoidCallback? onEnterFullScreen;
  final VoidCallback? onExitFullScreen;

  const AppFullScreenPlayer({
    Key? key,
    required this.config,
    this.url,
    this.contentWorker,
    this.onEnterFullScreen,
    this.onExitFullScreen,
  })  : assert(url != null || contentWorker != null),
        super(key: key);

  @override
  State<AppFullScreenPlayer> createState() => _AppFullScreenPlayerState();
}

class _AppFullScreenPlayerState extends State<AppFullScreenPlayer>
    with WidgetsBindingObserver {
  late bool isValidUrl;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    isValidUrl = (widget.url ?? "").trim().isNotEmpty;

    if (!isValidUrl) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Execute callback if page is mounted
        if (!mounted) return;

        widget.contentWorker?.loadContentData(context);
      });
    }

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
    ContentWorker<String>? contentWorker = widget.contentWorker;

    if (isValidUrl) {
      return AppFullScreenPlayerPart(
        config: widget.config,
        isFullScreen: isFullScreen,
        url: widget.url?.trim() ?? "",
      );
    } else if (contentWorker != null) {
      return NetworkWidget(
        callStatusSelector: (BuildContext context) => context.select(
          (ContentApiNotifier? apiNotifier) =>
              contentWorker.getResponseCallStatus(context, apiNotifier),
        ),
        childBuilder: (BuildContext context) {
          String? url = contentWorker.getResponseObject(context);
          if (url != null && url.trim().isNotEmpty) {
            return AppFullScreenPlayerPart(
              config: widget.config,
              isFullScreen: isFullScreen,
              url: url.trim(),
            );
          }

          return StatusText(Res.str.generalError);
        },
      );
    } else {
      return StatusText(Res.str.generalError);
    }
  }
}
