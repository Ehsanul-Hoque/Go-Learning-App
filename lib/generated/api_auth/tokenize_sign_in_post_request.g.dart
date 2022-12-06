// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/tokenize_sign_in_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenizeSignInPostRequest _$TokenizeSignInPostRequestFromJson(
        Map<String, dynamic> json) =>
    TokenizeSignInPostRequest(
      onetimeToken: json['onetime_token'] as String,
      fingerprintToken: json['fingerprint_token'] as String? ?? "",
    );

Map<String, dynamic> _$TokenizeSignInPostRequestToJson(
        TokenizeSignInPostRequest instance) =>
    <String, dynamic>{
      'onetime_token': instance.onetimeToken,
      'fingerprint_token': instance.fingerprintToken,
    };
