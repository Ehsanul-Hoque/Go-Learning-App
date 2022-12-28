// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_contents/resource_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceGetResponse _$ResourceGetResponseFromJson(Map<String, dynamic> json) =>
    ResourceGetResponse(
      success: json['success'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ResourceGetResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResourceGetResponseToJson(
        ResourceGetResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

ResourceGetResponseData _$ResourceGetResponseDataFromJson(
        Map<String, dynamic> json) =>
    ResourceGetResponseData(
      sId: json['_id'] as String?,
      contentType: json['content_type'] as String?,
      publicToAccess: json['public_to_access'] as bool?,
      locked: json['locked'] as bool?,
      title: json['title'] as String?,
      moduleId: json['module_id'] as String?,
      serial: json['serial'] as int?,
      link: (json['link'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ResourceGetResponseLink.fromJson(e as Map<String, dynamic>))
          .toList(),
      courseId: json['course_id'] as String?,
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$ResourceGetResponseDataToJson(
        ResourceGetResponseData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'content_type': instance.contentType,
      'public_to_access': instance.publicToAccess,
      'locked': instance.locked,
      'title': instance.title,
      'module_id': instance.moduleId,
      'serial': instance.serial,
      'link': instance.link?.map((e) => e?.toJson()).toList(),
      'course_id': instance.courseId,
      '__v': instance.iV,
    };

ResourceGetResponseLink _$ResourceGetResponseLinkFromJson(
        Map<String, dynamic> json) =>
    ResourceGetResponseLink(
      sId: json['_id'] as String?,
      name: json['name'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ResourceGetResponseLinkToJson(
        ResourceGetResponseLink instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'name': instance.name,
      'link': instance.link,
    };
