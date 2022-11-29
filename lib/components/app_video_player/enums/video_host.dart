import "package:app/components/app_video_player/utils/video_utils.dart";

enum VideoHost {
  vimeo(VideoUtils.isVimeoUrl, VideoUtils.getVimeoVideoId),
  youtube(VideoUtils.isYouTubeUrl, VideoUtils.getYouTubeVideoId),
  unknown(VideoUtils.isUnknownUrl, VideoUtils.getUnknownVideoId);

  final bool Function(String url) hasHostMatched;
  final String? Function(String url) getVideoId;

  const VideoHost(this.hasHostMatched, this.getVideoId);

  static VideoHost getHostFromUrl(String url) {
    return VideoHost.values.firstWhere(
      (VideoHost element) => element.hasHostMatched(url),
      orElse: () => VideoHost.unknown,
    );
  }
}
