// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_courses/course_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseGetResponse _$CourseGetResponseFromJson(Map<String, dynamic> json) =>
    CourseGetResponse(
      sId: json['_id'] as String?,
      rating: json['rating'] == null
          ? null
          : CourseGetResponseRating.fromJson(
              json['rating'] as Map<String, dynamic>),
      filter:
          (json['filter'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      categoryId: (json['category_id'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CategoryGetResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      certificate: json['certificate'] as bool?,
      language: json['language'] as String?,
      metaKeyword: json['meta_keyword'] as String?,
      metaDesc: json['meta_desc'] as String?,
      totalQuiz: json['total_quiz'] as int?,
      totalLecture: json['total_lecture'] as int?,
      title: json['title'] as String?,
      aliasName: json['alias_name'] as String?,
      description: json['description'] as String?,
      instructorName: json['instructor_name'] as String?,
      originalPrice: json['original_price'] as int?,
      price: json['price'] as int?,
      duration: json['duration'] as String?,
      access: json['access'] as String?,
      banner: json['banner'] as String?,
      preview: json['preview'] as String?,
      thumbnail: json['thumbnail'] as String?,
      immediateCategory: json['immediate_category'] == null
          ? null
          : CourseGetResponseImmediateCategory.fromJson(
              json['immediate_category'] as Map<String, dynamic>),
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$CourseGetResponseToJson(CourseGetResponse instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'rating': instance.rating?.toJson(),
      'filter': instance.filter,
      'category_id': instance.categoryId?.map((e) => e?.toJson()).toList(),
      'certificate': instance.certificate,
      'language': instance.language,
      'meta_keyword': instance.metaKeyword,
      'meta_desc': instance.metaDesc,
      'total_quiz': instance.totalQuiz,
      'total_lecture': instance.totalLecture,
      'title': instance.title,
      'alias_name': instance.aliasName,
      'description': instance.description,
      'instructor_name': instance.instructorName,
      'original_price': instance.originalPrice,
      'price': instance.price,
      'duration': instance.duration,
      'access': instance.access,
      'banner': instance.banner,
      'preview': instance.preview,
      'thumbnail': instance.thumbnail,
      'immediate_category': instance.immediateCategory?.toJson(),
      '__v': instance.iV,
    };

CourseGetResponseRating _$CourseGetResponseRatingFromJson(
        Map<String, dynamic> json) =>
    CourseGetResponseRating(
      totalRatingCount: json['total_rating_count'] as int?,
      average: json['average'] as int?,
    );

Map<String, dynamic> _$CourseGetResponseRatingToJson(
        CourseGetResponseRating instance) =>
    <String, dynamic>{
      'total_rating_count': instance.totalRatingCount,
      'average': instance.average,
    };

CourseGetResponseImmediateCategory _$CourseGetResponseImmediateCategoryFromJson(
        Map<String, dynamic> json) =>
    CourseGetResponseImmediateCategory(
      sId: json['_id'] as String?,
      name: json['name'] as String?,
      parentId: json['parent_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$CourseGetResponseImmediateCategoryToJson(
        CourseGetResponseImmediateCategory instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'name': instance.name,
      'parent_id': instance.parentId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.iV,
    };
