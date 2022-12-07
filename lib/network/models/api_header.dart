import "dart:io" show HttpHeaders;

import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../generated/api_header.g.dart";

@JsonSerializable()
class ApiHeader extends ApiModel {
  @JsonKey(name: HttpHeaders.contentTypeHeader)
  final String contentType;

  @JsonKey(name: "x-access-token")
  final String? xAccessToken;

  const ApiHeader({
    this.contentType = "application/json",
    this.xAccessToken,
  });

  factory ApiHeader.fromJson(Map<String, String?> json) =>
      _$ApiHeaderFromJson(json);

  @override
  Map<String, String> toJson() {
    Map<String, dynamic> headerJson = _$ApiHeaderToJson(this);
    Map<String, String> finalHeaderJson = <String, String>{};

    headerJson.forEach((String key, dynamic value) {
      if (value != null) {
        finalHeaderJson[key] = value as String;
      }
    });

    return finalHeaderJson;
  }
}
