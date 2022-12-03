import "package:app/network/models/api_courses/category_get_response.dart";
import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_courses/course_get_response.g.dart";

@JsonSerializable()
class CourseGetResponse extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "rating")
  final CourseGetResponseRating? rating;

  @JsonKey(name: "filter")
  final List<String?>? filter;

  @JsonKey(name: "category_id")
  final List<CategoryGetResponseData?>? categoryId;

  @JsonKey(name: "certificate")
  final bool? certificate;

  @JsonKey(name: "language")
  final String? language;

  @JsonKey(name: "meta_keyword")
  final String? metaKeyword;

  @JsonKey(name: "meta_desc")
  final String? metaDesc;

  @JsonKey(name: "total_quiz")
  final int? totalQuiz;

  @JsonKey(name: "total_lecture")
  final int? totalLecture;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "alias_name")
  final String? aliasName;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "instructor_name")
  final String? instructorName;

  @JsonKey(name: "original_price")
  final int? originalPrice;

  @JsonKey(name: "price")
  final int? price;

  @JsonKey(name: "duration")
  final String? duration;

  @JsonKey(name: "access")
  final String? access;

  @JsonKey(name: "banner")
  final String? banner;

  @JsonKey(name: "preview")
  final String? preview;

  @JsonKey(name: "thumbnail")
  final String? thumbnail;

  @JsonKey(name: "immediate_category")
  final CourseGetResponseImmediateCategory? immediateCategory;

  @JsonKey(name: "__v")
  final int? iV;

  const CourseGetResponse({
    this.sId,
    this.rating,
    this.filter,
    this.categoryId,
    this.certificate,
    this.language,
    this.metaKeyword,
    this.metaDesc,
    this.totalQuiz,
    this.totalLecture,
    this.title,
    this.aliasName,
    this.description,
    this.instructorName,
    this.originalPrice,
    this.price,
    this.duration,
    this.access,
    this.banner,
    this.preview,
    this.thumbnail,
    this.immediateCategory,
    this.iV,
  });

  factory CourseGetResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CourseGetResponseToJson(this);
}

@JsonSerializable()
class CourseGetResponseRating extends ApiModel {
  @JsonKey(name: "total_rating_count")
  final int? totalRatingCount;

  @JsonKey(name: "average")
  final int? average;

  const CourseGetResponseRating({
    this.totalRatingCount,
    this.average,
  });

  factory CourseGetResponseRating.fromJson(Map<String, dynamic> json) =>
      _$CourseGetResponseRatingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CourseGetResponseRatingToJson(this);
}

@JsonSerializable()
class CourseGetResponseImmediateCategory extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

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

  const CourseGetResponseImmediateCategory({
    this.sId,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory CourseGetResponseImmediateCategory.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$CourseGetResponseImmediateCategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$CourseGetResponseImmediateCategoryToJson(this);
}
