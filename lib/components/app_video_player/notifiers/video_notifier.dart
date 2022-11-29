import "package:app/components/app_video_player/enums/video_host.dart";
import "package:flutter/foundation.dart" show ChangeNotifier;
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart";

class VideoNotifier extends ChangeNotifier {
  /// Constructor
  VideoNotifier({String initialVideoUrl = ""}) {
    setVideo(initialVideoUrl);
  }

  // Fields
  String _videoUrl = "";
  String _videoId = "";
  VideoHost _videoHost = VideoHost.unknown;

  // Getters
  String get videoUrl => _videoUrl;
  String get videoId => _videoId;
  VideoHost get videoHost => _videoHost;
  bool get hasSelectedVideo => videoUrl.isNotEmpty;

  /// Method to set video information from video url
  void setVideo(String url) {
    _videoUrl = url;
    if (url.isNotEmpty) {
      _videoHost = VideoHost.getHostFromUrl(url);
      _videoId = _videoHost.getVideoId(url) ?? "";
    } else {
      _videoHost = VideoHost.unknown;
      _videoId = "";
    }

    notifyListeners();
  }

  /// Static method to create simple provider
  static SingleChildWidget createProvider({String initialVideoUrl = ""}) =>
      ChangeNotifierProvider<VideoNotifier>(
        create: (BuildContext context) =>
            VideoNotifier(initialVideoUrl: initialVideoUrl),
      );
}
