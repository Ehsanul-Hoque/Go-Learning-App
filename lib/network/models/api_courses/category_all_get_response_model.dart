import "package:app/network/models/api_courses/category_model.dart";
import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_courses/category_all_get_response_serializer.dart";

class CategoryAllGetResponseModel extends BaseApiModel {
  final String? success;
  final List<CategoryModel?>? categories;

  const CategoryAllGetResponseModel({this.success, this.categories})
      : super(serializer: const CategoryAllGetResponseSerializer());

  @override
  String get className => "CategoryAllGetResponseModel";
}
