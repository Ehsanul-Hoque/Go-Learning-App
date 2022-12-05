// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../network/models/api_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiHeader _$ApiHeaderFromJson(Map<String, dynamic> json) => ApiHeader(
      contentType: json['content-type'] as String? ?? "application/json",
      xAccessToken: json['x-access-token'] as String?,
    );

Map<String, dynamic> _$ApiHeaderToJson(ApiHeader instance) => <String, dynamic>{
      'content-type': instance.contentType,
      'x-access-token': instance.xAccessToken,
    };
