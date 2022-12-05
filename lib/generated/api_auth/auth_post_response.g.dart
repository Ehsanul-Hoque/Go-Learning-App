// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/auth_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthPostResponse _$AuthPostResponseFromJson(Map<String, dynamic> json) =>
    AuthPostResponse(
      xAccessToken: json['x-access-token'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$AuthPostResponseToJson(AuthPostResponse instance) =>
    <String, dynamic>{
      'x-access-token': instance.xAccessToken,
      'msg': instance.msg,
    };
