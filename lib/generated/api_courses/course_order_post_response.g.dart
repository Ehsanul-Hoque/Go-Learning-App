// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_courses/course_order_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseOrderPostResponse _$CourseOrderPostResponseFromJson(
        Map<String, dynamic> json) =>
    CourseOrderPostResponse(
      success: json['success'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$CourseOrderPostResponseToJson(
        CourseOrderPostResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
    };
