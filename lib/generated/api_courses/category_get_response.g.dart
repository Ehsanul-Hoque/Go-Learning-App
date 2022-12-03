// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_courses/category_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryGetResponse _$CategoryGetResponseFromJson(Map<String, dynamic> json) =>
    CategoryGetResponse(
      success: json['success'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CategoryGetResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryGetResponseToJson(
        CategoryGetResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

CategoryGetResponseData _$CategoryGetResponseDataFromJson(
        Map<String, dynamic> json) =>
    CategoryGetResponseData(
      sId: json['_id'] as String?,
      banner: json['banner'] as String?,
      name: json['name'] as String?,
      parentId: json['parent_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
      subcategories: (json['subs'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CategoryGetResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryGetResponseDataToJson(
        CategoryGetResponseData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'banner': instance.banner,
      'name': instance.name,
      'parent_id': instance.parentId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.iV,
      'subs': instance.subcategories?.map((e) => e?.toJson()).toList(),
    };
