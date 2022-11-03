import "package:app/network/models/api_courses/category_all_get_response_model.dart";
import "package:app/network/models/api_courses/category_model.dart";
import "package:app/network/serializers/api_courses/category_serializer.dart";
import "package:app/serializers/serializer.dart";

class CategoryAllGetResponseSerializer
    extends Serializer<CategoryAllGetResponseModel> {
  const CategoryAllGetResponseSerializer();

  @override
  CategoryAllGetResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CategoryAllGetResponseModel();

    return CategoryAllGetResponseModel(
      success: json["success"],
      categories: (json["data"] as List<dynamic>?)
          ?.map((dynamic category) => category as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? category) => (category == null)
                ? null
                : const CategorySerializer().fromJson(category),
          )
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(CategoryAllGetResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["success"] = serializable.success;
    data["data"] = serializable.categories
        ?.map(
          (CategoryModel? category) => (category == null)
              ? null
              : const CategorySerializer().toJson(category),
        )
        .toList();

    return data;
  }
}
