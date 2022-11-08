// ignore_for_file: always_specify_types

import "package:app/network/converters/default_converters/json_array_converter.dart";
import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_courses/category_response_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/models/base_api_response_model.dart";
import "package:app/network/network_call.dart";
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
  /// API network responses
  late NetworkResponse<BaseApiResponseModel<CategoryResponseModel>>
      allCategoriesGetInfo = NetworkResponse();

  late NetworkResponse<List<CourseGetResponseModel?>> allCoursesGetInfo =
      NetworkResponse<List<CourseGetResponseModel?>>();

  /// Constructor
  CourseApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<CourseApiNotifier>(
        create: (BuildContext context) => CourseApiNotifier(),
      );

  /// Method to get all courses list
  Future<NetworkResponse<BaseApiResponseModel<CategoryResponseModel>>>
      getAllCategories() async => await NetworkCall(
            client: defaultClient,
            request: const NetworkRequest.get(
              apiEndPoint: "/category/category_tree_view",
              serializer:
                  BaseApiResponseSerializer(CategoryResponseSerializer()),
              converter: JsonObjectConverter<
                  BaseApiResponseModel<CategoryResponseModel>>(),
            ),
            response: allCategoriesGetInfo,
            updateListener: () => notifyListeners(),
          ).execute();

  /// Method to get all courses list
  Future<NetworkResponse<List<CourseGetResponseModel?>>>
      getAllCourses() async => await NetworkCall(
            client: defaultClient,
            request: const NetworkRequest.get(
              apiEndPoint: "/course/get",
              serializer: CourseGetResponseSerializer(),
              converter: JsonArrayConverter<CourseGetResponseModel>(),
            ),
            response: allCoursesGetInfo,
            updateListener: () => notifyListeners(),
          ).execute();
}
