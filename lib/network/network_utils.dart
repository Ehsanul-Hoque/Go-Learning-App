import "package:app/utils/utils.dart";
import "package:internet_connection_checker/internet_connection_checker.dart";

class NetworkUtils {
  static Future<bool> hasInternetConnection() async {
    return await InternetConnectionChecker().hasConnection;
  }

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
}
