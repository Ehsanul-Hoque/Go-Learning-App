import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/lecture_get_response.dart";
import "package:app/network/models/api_contents/resource_get_response.dart";
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

  static String lectureGetApiEndpoint(String? contentId) {
    return (contentId == null)
        ? "/lecture/get"
        : (contentId.isEmpty ? "/lecture/get" : "/lecture/get?_id=$contentId");
  }

  static String resourceGetApiEndpoint(String? contentId) {
    return (contentId == null)
        ? "/resource/get"
        : (contentId.isEmpty
            ? "/resource/get"
            : "/resource/get?_id=$contentId");
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
      client: defaultAuthenticatedClient,
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
  Future<NetworkResponse<LectureGetResponse>> getLecture(String? contentId) {
    return const Network().createExecuteCall(
      client: defaultClient,
      request: NetworkRequest.get(
        apiEndPoint: lectureGetApiEndpoint(contentId),
      ),
      responseConverter: const JsonObjectConverter<LectureGetResponse>(
        LectureGetResponse.fromJson,
      ),
      callback: NetworkCallback<LectureGetResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
    );
  }

  NetworkResponse<LectureGetResponse> lectureGetResponse(String? contentId) =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + lectureGetApiEndpoint(contentId),
      );

  /// Methods to get a resource (a type of content) of a course
  Future<NetworkResponse<ResourceGetResponse>> getResource(String? contentId) {
    return const Network().createExecuteCall(
      client: defaultClient,
      request: NetworkRequest.get(
        apiEndPoint: resourceGetApiEndpoint(contentId),
      ),
      responseConverter: const JsonObjectConverter<ResourceGetResponse>(
        ResourceGetResponse.fromJson,
      ),
      callback: NetworkCallback<ResourceGetResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
    );
  }

  NetworkResponse<ResourceGetResponse> resourceGetResponse(String? contentId) =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + resourceGetApiEndpoint(contentId),
      );
}
