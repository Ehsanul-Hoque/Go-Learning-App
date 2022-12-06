import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_auth/tokenize_sign_in_post_request.g.dart";

@JsonSerializable()
class TokenizeSignInPostRequest extends ApiModel {
  @JsonKey(name: "onetime_token")
  final String onetimeToken;

  @JsonKey(name: "fingerprint_token")
  final String fingerprintToken;

  const TokenizeSignInPostRequest({
    required this.onetimeToken,
    this.fingerprintToken = "",
  });

  factory TokenizeSignInPostRequest.fromJson(Map<String, dynamic> json) =>
      _$TokenizeSignInPostRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TokenizeSignInPostRequestToJson(this);
}
