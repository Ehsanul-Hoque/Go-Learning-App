import "dart:io" show HttpHeaders;

import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../generated/api_header.g.dart";

@JsonSerializable()
class ApiHeader extends ApiModel {
  @JsonKey(
    name: HttpHeaders.contentTypeHeader,
    defaultValue: "application/json",
  )
  final String contentType;

  @JsonKey(name: "x-access-token")
  final String? xAccessToken;

  const ApiHeader({
    this.contentType = "application/json",
    this.xAccessToken,
  });

  factory ApiHeader.fromJson(Map<String, String> json) =>
      _$ApiHeaderFromJson(json);

  @override
  Map<String, String> toJson() => _$ApiHeaderToJson(this).map(
        (String key, dynamic value) =>
            MapEntry<String, String>(key, value as String),
      );
}
