import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/lecture_get_response.dart";
import "package:app/network/network.dart";
import "package:app/network/network_callback.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class ContentApiNotifier extends ApiNotifier {
  /// API endpoints
  static String contentsTreeGetApiEndpoint(String? courseId) {
    return (courseId == null)
        ? "/full_course/get_full_course_tree"
        : (courseId.isEmpty
            ? "/full_course/get_full_course_tree"
            : "/full_course/get_full_course_tree?course_id=$courseId");
  }

  static String lectureGetApiEndpoint(String? lectureId) {
    return (lectureId == null)
        ? "/lecture/get"
        : (lectureId.isEmpty ? "/lecture/get" : "/lecture/get?_id=$lectureId");
  }

  /// Constructor
  ContentApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<ContentApiNotifier>(
        create: (BuildContext context) => ContentApiNotifier(),
      );

  /// Methods to get whole content tree of a course
  Future<NetworkResponse<ContentTreeGetResponse>> getContentTree(
    String? courseId,
  ) {
    return const Network().createExecuteCall(
      client: defaultClient,
      request: NetworkRequest.get(
        apiEndPoint: contentsTreeGetApiEndpoint(courseId),
      ),
      responseConverter: const JsonObjectConverter<ContentTreeGetResponse>(
        ContentTreeGetResponse.fromJson,
      ),
      callback: NetworkCallback<ContentTreeGetResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
    );
  }

  NetworkResponse<ContentTreeGetResponse> contentTreeGetResponse(
    String? courseId,
  ) =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + contentsTreeGetApiEndpoint(courseId),
      );

  /// Methods to get a lecture (a type of content) of a course
  Future<NetworkResponse<LectureGetResponse>> getLecture(String? lectureId) {
    return const Network().createExecuteCall(
      client: defaultClient,
      request: NetworkRequest.get(
        apiEndPoint: lectureGetApiEndpoint(lectureId),
      ),
      responseConverter: const JsonObjectConverter<LectureGetResponse>(
        LectureGetResponse.fromJson,
      ),
      callback: NetworkCallback<LectureGetResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
    );
  }

  NetworkResponse<LectureGetResponse> lectureGetResponse(String? lectureId) =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + lectureGetApiEndpoint(lectureId),
      );
}
