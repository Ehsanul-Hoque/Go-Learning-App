import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/course_get_response_serializer.dart";

class CourseGetResponseModel extends BaseApiModel {
  final String? sId;
  final CgrRatingModel? rating;
  final List<String?>? filter;
  final List<CgrCategoryModel?>? categoryId;
  final bool? certificate;
  final String? language;
  final String? metaKeyword;
  final String? metaDesc;
  final int? totalQuiz;
  final int? totalLecture;
  final String? title;
  final String? aliasName;
  final String? description;
  final String? instructorName;
  final int? originalPrice;
  final int? price;
  final String? duration;
  final String? access;
  final String? banner;
  final String? preview;
  final String? thumbnail;
  final CgrImmediateCategoryModel? immediateCategory;
  final int? iV;

  const CourseGetResponseModel({
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
  }) : super(serializer: const CourseGetResponseSerializer());

  @override
  String get className => "CourseResponseModel";
}

class CgrRatingModel extends BaseApiModel {
  final int? totalRatingCount;
  final int? average;

  const CgrRatingModel({this.totalRatingCount, this.average})
      : super(serializer: const CgrRatingSerializer());

  @override
  String get className => "CgrRatingModel";
}

class CgrCategoryModel extends BaseApiModel {
  final String? sId;
  final String? name;
  final String? parentId;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;
  final String? banner;

  const CgrCategoryModel({
    this.sId,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.banner,
  }) : super(serializer: const CgrCategorySerializer());

  @override
  String get className => "CgrCategoryModel";
}

class CgrImmediateCategoryModel extends BaseApiModel {
  final String? sId;
  final String? name;
  final String? parentId;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;

  const CgrImmediateCategoryModel({
    this.sId,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  }) : super(serializer: const CgrImmediateCategorySerializer());

  @override
  String get className => "CgrImmediateCategoryModel";
}
