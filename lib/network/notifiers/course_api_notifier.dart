import "package:app/network/converters/default_converters/json_array_converter.dart";
import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/interceptors/default_interceptors/auth_interceptor.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/models/api_courses/category_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/network/models/api_courses/course_order_post_request.dart";
import "package:app/network/models/api_courses/course_order_post_response.dart";
import "package:app/network/network.dart";
import "package:app/network/network_callback.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class CourseApiNotifier extends ApiNotifier {
  /// API endpoints
  static const String allCategoriesGetApiEndpoint =
      "/category/category_tree_view";
  static const String allCoursesGetApiEndpoint = "/course/get";
  static const String courseOrderPostApiEndpoint = "/order/create";

  /// Constructor
  CourseApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<CourseApiNotifier>(
        create: (BuildContext context) => CourseApiNotifier(),
      );

  /// Methods to get all courses list
  Future<NetworkResponse<CategoryGetResponse>> getAllCategories() =>
      const Network().createExecuteCall(
        client: defaultClient,
        request: const NetworkRequest.get(
          apiEndPoint: allCategoriesGetApiEndpoint,
        ),
        responseConverter: const JsonObjectConverter<CategoryGetResponse>(
          CategoryGetResponse.fromJson,
        ),
        callback: NetworkCallback<CategoryGetResponse>(
          onUpdate: (_) => notifyListeners(),
        ),
      );

  NetworkResponse<CategoryGetResponse> get allCategoriesGetResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + allCategoriesGetApiEndpoint,
      );

  /// Methods to get all courses list
  Future<NetworkResponse<List<CourseGetResponse>>> getAllCourses() =>
      const Network().createExecuteCall(
        client: defaultClient,
        request: const NetworkRequest.get(
          apiEndPoint: allCoursesGetApiEndpoint,
        ),
        responseConverter: const JsonArrayConverter<CourseGetResponse>(
          CourseGetResponse.fromJson,
        ),
        callback: NetworkCallback<List<CourseGetResponse>>(
          onUpdate: (_) => notifyListeners(),
        ),
      );

  NetworkResponse<List<CourseGetResponse>> get allCoursesGetResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + allCoursesGetApiEndpoint,
      );

  /// Methods to place order for a course
  Future<NetworkResponse<CourseOrderPostResponse>> postCourseOrder(
    CourseOrderPostRequest requestBody,
  ) {
    return const Network().createExecuteCall(
      client: defaultAuthenticatedClient,
      requestInterceptors: <NetworkRequestInterceptor>[AuthInterceptor()],
      request: NetworkRequest.post(
        apiEndPoint: courseOrderPostApiEndpoint,
        body: requestBody.toJson(),
      ),
      responseConverter: const JsonObjectConverter<CourseOrderPostResponse>(
        CourseOrderPostResponse.fromJson,
      ),
      callback: NetworkCallback<CourseOrderPostResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<CourseOrderPostResponse> get courseOrderPostResponse =>
      Network.getOrCreateResponse(
        defaultAuthenticatedClient.baseUrl + courseOrderPostApiEndpoint,
      );
}
