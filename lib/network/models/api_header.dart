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
    required this.contentType,
    this.xAccessToken,
  });

  factory ApiHeader.fromJson(Map<String, dynamic> json) =>
      _$ApiHeaderFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ApiHeaderToJson(this);
}
