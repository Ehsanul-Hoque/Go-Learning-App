// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/edit_profile_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfilePostResponse _$EditProfilePostResponseFromJson(
        Map<String, dynamic> json) =>
    EditProfilePostResponse(
      success: json['success'] as String?,
      msg: json['msg'] as String?,
      data: json['data'] as bool?,
    );

Map<String, dynamic> _$EditProfilePostResponseToJson(
        EditProfilePostResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'msg': instance.msg,
      'data': instance.data,
    };
