// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/sign_up_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpPostRequest _$SignUpPostRequestFromJson(Map<String, dynamic> json) =>
    SignUpPostRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignUpPostRequestToJson(SignUpPostRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
    };
