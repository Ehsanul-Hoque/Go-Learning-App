import "package:app/network/models/api_courses/category_all_get_response_model.dart";
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
                : const CagrCategorySerializer().fromJson(category),
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
          (CagrCategoryModel? category) => (category == null)
              ? null
              : const CagrCategorySerializer().toJson(category),
        )
        .toList();

    return data;
  }
}

class CagrCategorySerializer extends Serializer<CagrCategoryModel> {
  const CagrCategorySerializer();

  @override
  CagrCategoryModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CagrCategoryModel();

    return CagrCategoryModel(
      sId: json["_id"],
      banner: json["banner"],
      name: json["name"],
      parentId: json["parent_id"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
      subcategories: (json["subs"] as List<dynamic>?)
          ?.map((dynamic category) => category as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? category) => (category == null)
                ? null
                : const CagrCategorySerializer().fromJson(category),
          )
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(CagrCategoryModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["banner"] = serializable.banner;
    data["name"] = serializable.name;
    data["parent_id"] = serializable.parentId;
    data["createdAt"] = serializable.createdAt;
    data["updatedAt"] = serializable.updatedAt;
    data["__v"] = serializable.iV;
    data["subs"] = serializable.subcategories
        ?.map(
          (CagrCategoryModel? category) => (category == null)
              ? null
              : const CagrCategorySerializer().toJson(category),
        )
        .toList();

    return data;
  }
}
