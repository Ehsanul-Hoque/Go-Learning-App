import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_courses/category_get_response.g.dart";

@JsonSerializable()
class CategoryGetResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "data")
  final List<CategoryGetResponseData?>? data;

  CategoryGetResponse({
    this.success,
    this.data,
  });

  factory CategoryGetResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryGetResponseToJson(this);
}

@JsonSerializable()
class CategoryGetResponseData extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "banner")
  final String? banner;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "parent_id")
  final String? parentId;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  @JsonKey(name: "__v")
  final int? iV;

  @JsonKey(name: "subs")
  final List<CategoryGetResponseData?>? subcategories;

  const CategoryGetResponseData({
    this.sId,
    this.banner,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.subcategories,
  });

  factory CategoryGetResponseData.fromJson(Map<String, dynamic> json) =>
      _$CategoryGetResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CategoryGetResponseDataToJson(this);
}
