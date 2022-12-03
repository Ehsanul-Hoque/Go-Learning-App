import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_auth/sign_in_post_response.g.dart";

@JsonSerializable()
class SignInPostResponse extends ApiModel {
  @JsonKey(name: "x-access-token")
  final String? xAccessToken;

  @JsonKey(name: "msg")
  final String? msg;

  const SignInPostResponse({
    this.xAccessToken,
    this.msg,
  });

  factory SignInPostResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInPostResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignInPostResponseToJson(this);
}
