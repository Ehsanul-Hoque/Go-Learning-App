import "package:app/components/app_video_player/config/app_video_player_config.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:flutter/widgets.dart";
import "package:webview_flutter/webview_flutter.dart";

class VimeoVideoPlayer extends StatelessWidget {
  final AppVideoPlayerConfig config;
  final String videoUrl;

  const VimeoVideoPlayer({
    Key? key,
    required this.config,
    required this.videoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String fullUrl = "https://golearningbd.com/video/vimeo"
        "?video_url=${Uri.encodeComponent(videoUrl)}"
        "&token=${UserBox.accessToken}"
        "&loop=0"
        "&autoplay=0";

    return WebView(
      initialUrl: fullUrl,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
