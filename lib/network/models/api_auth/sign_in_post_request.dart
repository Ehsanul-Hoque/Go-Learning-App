import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_auth/sign_in_post_request.g.dart";

@JsonSerializable()
class SignInPostRequest extends ApiModel {
  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "password")
  final String? password;

  @JsonKey(name: "fingerprint_token")
  final String? fingerprintToken;

  const SignInPostRequest({
    this.email,
    this.password,
    this.fingerprintToken,
  });

  factory SignInPostRequest.fromJson(Map<String, dynamic> json) =>
      _$SignInPostRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignInPostRequestToJson(this);
}
