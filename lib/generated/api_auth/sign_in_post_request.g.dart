// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/sign_in_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInPostRequest _$SignInPostRequestFromJson(Map<String, dynamic> json) =>
    SignInPostRequest(
      email: json['email'] as String?,
      password: json['password'] as String?,
      fingerprintToken: json['fingerprint_token'] as String?,
    );

Map<String, dynamic> _$SignInPostRequestToJson(SignInPostRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'fingerprint_token': instance.fingerprintToken,
    };
