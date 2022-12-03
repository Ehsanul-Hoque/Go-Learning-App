// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/sign_in_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInPostResponse _$SignInPostResponseFromJson(Map<String, dynamic> json) =>
    SignInPostResponse(
      xAccessToken: json['x-access-token'] as String?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$SignInPostResponseToJson(SignInPostResponse instance) =>
    <String, dynamic>{
      'x-access-token': instance.xAccessToken,
      'msg': instance.msg,
    };
