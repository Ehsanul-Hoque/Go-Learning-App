// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_contents/content_tree_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentTreeGetResponse _$ContentTreeGetResponseFromJson(
        Map<String, dynamic> json) =>
    ContentTreeGetResponse(
      haveFullAccess: json['have_full_access'] as bool?,
      module: (json['module'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ContentTreeGetResponseModule.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentTreeGetResponseToJson(
        ContentTreeGetResponse instance) =>
    <String, dynamic>{
      'have_full_access': instance.haveFullAccess,
      'module': instance.module?.map((e) => e?.toJson()).toList(),
    };

ContentTreeGetResponseModule _$ContentTreeGetResponseModuleFromJson(
        Map<String, dynamic> json) =>
    ContentTreeGetResponseModule(
      sId: json['_id'] as String?,
      parentModuleId: json['parent_module_id'] as String?,
      title: json['title'] as String?,
      serial: json['serial'] as int?,
      courseId: json['course_id'] as String?,
      iV: json['__v'] as int?,
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ContentTreeGetResponseContents.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      subs: (json['subs'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ContentTreeGetResponseModule.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContentTreeGetResponseModuleToJson(
        ContentTreeGetResponseModule instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'parent_module_id': instance.parentModuleId,
      'title': instance.title,
      'serial': instance.serial,
      'course_id': instance.courseId,
      '__v': instance.iV,
      'contents': instance.contents?.map((e) => e?.toJson()).toList(),
      'subs': instance.subs?.map((e) => e?.toJson()).toList(),
    };

ContentTreeGetResponseContents _$ContentTreeGetResponseContentsFromJson(
        Map<String, dynamic> json) =>
    ContentTreeGetResponseContents(
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
      courseId: json['course_id'] as String?,
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$ContentTreeGetResponseContentsToJson(
        ContentTreeGetResponseContents instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'content_type': instance.contentType,
      'public_to_access': instance.publicToAccess,
      'locked': instance.locked,
      'title': instance.title,
      'module_id': instance.moduleId,
      'serial': instance.serial,
      'time_stamp': instance.timeStamp?.map((e) => e?.toJson()).toList(),
      'course_id': instance.courseId,
      '__v': instance.iV,
    };
