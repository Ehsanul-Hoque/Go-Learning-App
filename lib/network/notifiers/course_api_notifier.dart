// ignore_for_file: always_specify_types

import "package:app/network/converters/default_converters/json_array_converter.dart";
import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_courses/category_all_get_response_model.dart";
import "package:app/network/models/api_courses/course_get_response_model.dart";
import "package:app/network/network_call.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/serializers/category_all_get_response_serializer.dart";
import "package:app/network/serializers/course_get_response_serializer.dart";

class CourseApiNotifier extends ApiNotifier {
  /// API network responses
  late NetworkResponse<CategoryAllGetResponseModel> allCategoriesGetInfo =
      NetworkResponse<CategoryAllGetResponseModel>();

  late NetworkResponse<List<CourseGetResponseModel?>> allCoursesGetInfo =
      NetworkResponse<List<CourseGetResponseModel?>>();

  /// Constructor
  CourseApiNotifier();

  /// Method to get all courses list
  Future<NetworkResponse<CategoryAllGetResponseModel>>
      getAllCategories() async => await NetworkCall(
            client: defaultClient,
            request: const NetworkRequest.get(
              apiEndPoint: "/category/category_tree_view",
              serializer: CategoryAllGetResponseSerializer(),
              converter: JsonObjectConverter<CategoryAllGetResponseModel>(),
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
