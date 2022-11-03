import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_courses/category_serializer.dart";

class CategoryModel extends BaseApiModel {
  final String? sId;
  final String? banner;
  final String? name;
  final String? parentId;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;
  final List<CategoryModel?>? subcategories;

  const CategoryModel({
    this.sId,
    this.banner,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.subcategories,
  }) : super(serializer: const CategorySerializer());

  @override
  String get className => "CategoryModel";
}
