import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/components/app_video_player/enums/video_host_type.dart";
import "package:app/components/app_video_player/sub_players/vimeo_video_player.dart";
import "package:app/components/app_video_player/sub_players/youtube_video_player.dart";
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart" show ValueKey, Widget;

class VideoUtils {
  // YouTube related methods
  static bool isYouTubeUrl(String url) {
    try {
      Uri uri = Uri.parse(url);
      return uri.host.contains(RegExp(r"youtu\.?be"));
    } catch (e, s) {
      Utils.log("", error: e, stackTrace: s);
      return false;
    }
  }

  static String? getYouTubeVideoId(String url) {
    try {
      if (!isYouTubeUrl(url)) return null;

      Uri uri = Uri.parse(url);
      String videoId = uri.queryParameters["v"] ??
          uri.queryParameters["vi"] ??
          uri.pathSegments[uri.pathSegments.length - 1];
      return videoId.isNotEmpty ? videoId : null;
    } catch (e, s) {
      Utils.log("", error: e, stackTrace: s);
      return null;
    }
  }

  static Widget getYouTubePlayer(String url, AppVideoPlayerConfig config) {
    VideoHostType videoHost = VideoHostType.getHostFromUrl(url);
    String videoId = videoHost.getVideoId(url) ?? "";

    return YouTubeVideoPlayer(
      key: ValueKey<String>("youtube_video_player_$videoId"),
      config: config,
      videoId: videoId,
    );
  }

  // Vimeo related methods
  static bool isVimeoUrl(String url) {
    try {
      Uri uri = Uri.parse(url);
      return uri.host.contains("vimeo");
    } catch (e, s) {
      Utils.log("", error: e, stackTrace: s);
      return false;
    }
  }

  static String? getVimeoVideoId(String url) {
    try {
      if (!isVimeoUrl(url)) return null;

      Uri uri = Uri.parse(url);
      String videoId = uri.pathSegments[uri.pathSegments.length - 1];
      return videoId.isNotEmpty ? videoId : null;
    } catch (e, s) {
      Utils.log("", error: e, stackTrace: s);
      return null;
    }
  }

  static Widget getVimeoPlayer(String url, AppVideoPlayerConfig config) {
    VideoHostType videoHost = VideoHostType.getHostFromUrl(url);
    String videoId = videoHost.getVideoId(url) ?? "";

    return VimeoVideoPlayer(
      key: ValueKey<String>("vimeo_video_player_$videoId"),
      config: config,
      videoUrl: url,
    );
  }

  // Unknown video host related methods
  static bool isUnknownUrl(String url) => false;

  static String? getUnknownVideoId(String url) => null;
}
