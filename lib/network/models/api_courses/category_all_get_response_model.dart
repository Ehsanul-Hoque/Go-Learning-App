import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/category_all_get_response_serializer.dart";

class CategoryAllGetResponseModel extends BaseApiModel {
  final String? success;
  final List<CagrCategoryModel?>? categories;

  const CategoryAllGetResponseModel({this.success, this.categories})
      : super(serializer: const CategoryAllGetResponseSerializer());

  @override
  String get className => "CategoryAllGetResponseModel";
}

class CagrCategoryModel extends BaseApiModel {
  final String? sId;
  final String? banner;
  final String? name;
  final String? parentId;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;
  final List<CagrCategoryModel?>? subcategories;

  const CagrCategoryModel({
    this.sId,
    this.banner,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.subcategories,
  }) : super(serializer: const CagrCategorySerializer());

  @override
  String get className => "CagrCategoryModel";
}
