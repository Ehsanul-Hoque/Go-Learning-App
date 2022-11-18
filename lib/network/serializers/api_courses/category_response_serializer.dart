import "package:app/network/models/api_courses/category_response_model.dart";
import "package:app/network/serializers/serializer_helper.dart";
import "package:app/serializers/serializer.dart";

class CategoryResponseSerializer extends Serializer<CategoryResponseModel> {
  const CategoryResponseSerializer();

  @override
  CategoryResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CategoryResponseModel();

    return CategoryResponseModel(
      sId: json["_id"],
      banner: json["banner"],
      name: json["name"],
      parentId: json["parent_id"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
      subcategories: SerializerHelper.jsonToModelList<CategoryResponseModel>(
        json["subs"],
        const CategoryResponseSerializer(),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(CategoryResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["banner"] = serializable.banner;
    data["name"] = serializable.name;
    data["parent_id"] = serializable.parentId;
    data["createdAt"] = serializable.createdAt;
    data["updatedAt"] = serializable.updatedAt;
    data["__v"] = serializable.iV;
    data["subs"] = SerializerHelper.modelToJsonList<CategoryResponseModel>(
      serializable.subcategories,
      const CategoryResponseSerializer(),
    );

    return data;
  }
}
