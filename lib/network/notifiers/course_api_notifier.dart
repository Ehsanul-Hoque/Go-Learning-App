// ignore_for_file: always_specify_types

import "package:app/network/converters/default_converters/json_array_converter.dart";
import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_courses/category_response_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/models/base_api_response_model.dart";
import "package:app/network/network.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/serializers/api_courses/category_response_serializer.dart";
import "package:app/network/serializers/api_courses/course_get_response_serializer.dart";
import "package:app/network/serializers/base_api_response_serializer.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class CourseApiNotifier extends ApiNotifier {
  /// API endpoints
  static const String allCategoriesGetApiEndpoint =
      "/category/category_tree_view";
  static const String allCoursesGetApiEndpoint = "/course/get";

  /// Constructor
  CourseApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<CourseApiNotifier>(
        create: (BuildContext context) => CourseApiNotifier(),
      );

  /// Methods to get all courses list
  Future<NetworkResponse<BaseApiResponseModel<CategoryResponseModel>>>
      getAllCategories() =>
          Network(updateListener: () => notifyListeners()).createExecuteCall(
            client: defaultClient,
            request: const NetworkRequest.get(
              apiEndPoint: allCategoriesGetApiEndpoint,
              serializer:
                  BaseApiResponseSerializer(CategoryResponseSerializer()),
              converter: JsonObjectConverter<
                  BaseApiResponseModel<CategoryResponseModel>>(),
            ),
          );

  NetworkResponse<BaseApiResponseModel<CategoryResponseModel>>
      get allCategoriesGetResponse => Network.getOrCreateResponse(
            defaultClient.baseUrl + allCategoriesGetApiEndpoint,
          );

  /// Methods to get all courses list
  Future<NetworkResponse<List<CourseGetResponseModel>>> getAllCourses() =>
      Network(updateListener: () => notifyListeners()).createExecuteCall(
        client: defaultClient,
        request: const NetworkRequest.get(
          apiEndPoint: allCoursesGetApiEndpoint,
          serializer: CourseGetResponseSerializer(),
          converter: JsonArrayConverter<CourseGetResponseModel>(),
        ),
      );

  NetworkResponse<List<CourseGetResponseModel>> get allCoursesGetResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + allCoursesGetApiEndpoint,
      );
}
