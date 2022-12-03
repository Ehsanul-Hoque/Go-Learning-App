// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_contents/lecture_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureGetResponse _$LectureGetResponseFromJson(Map<String, dynamic> json) =>
    LectureGetResponse(
      success: json['success'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : LectureGetResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LectureGetResponseToJson(LectureGetResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

LectureGetResponseData _$LectureGetResponseDataFromJson(
        Map<String, dynamic> json) =>
    LectureGetResponseData(
      sId: json['_id'] as String?,
      contentType: json['content_type'] as String?,
      publicToAccess: json['public_to_access'] as bool?,
      locked: json['locked'] as bool?,
      title: json['title'] as String?,
      moduleId: json['module_id'] as String?,
      serial: json['serial'] as int?,
      timeStamp: (json['time_stamp'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : LectureGetResponseTimeStamp.fromJson(e as Map<String, dynamic>))
          .toList(),
      link: json['link'] as String?,
      courseId: json['course_id'] as String?,
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$LectureGetResponseDataToJson(
        LectureGetResponseData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'content_type': instance.contentType,
      'public_to_access': instance.publicToAccess,
      'locked': instance.locked,
      'title': instance.title,
      'module_id': instance.moduleId,
      'serial': instance.serial,
      'time_stamp': instance.timeStamp?.map((e) => e?.toJson()).toList(),
      'link': instance.link,
      'course_id': instance.courseId,
      '__v': instance.iV,
    };
