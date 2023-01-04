import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/app_video_player/utils/video_utils.dart";
import "package:flutter/widgets.dart" show Widget;

typedef HostMatcher = bool Function(String url);
typedef VideoIdGetter = String? Function(String url);
typedef PlayerGetter = Widget? Function(
  String url,
  AppVideoPlayerConfig config,
);

enum VideoHostType {
  /// Vimeo type
  vimeo(
    hasHostMatched: VideoUtils.isVimeoUrl,
    getVideoId: VideoUtils.getVimeoVideoId,
    getPlayer: VideoUtils.getVimeoPlayer,
  ),

  /// YouTube type
  youtube(
    hasHostMatched: VideoUtils.isYouTubeUrl,
    getVideoId: VideoUtils.getYouTubeVideoId,
    getPlayer: VideoUtils.getYouTubePlayer,
  ),

  /// Unknown type
  unknown(
    hasHostMatched: VideoUtils.isUnknownUrl,
    getVideoId: VideoUtils.getUnknownVideoId,
  );

  /// All-argument constructor
  const VideoHostType({
    required this.hasHostMatched,
    required this.getVideoId,
    this.getPlayer,
  });

  final HostMatcher hasHostMatched;
  final VideoIdGetter getVideoId;
  final PlayerGetter? getPlayer;

  static VideoHostType getHostFromUrl(String url) {
    return VideoHostType.values.firstWhere(
      (VideoHostType element) => element.hasHostMatched(url),
      orElse: () => VideoHostType.unknown,
    );
  }
}
