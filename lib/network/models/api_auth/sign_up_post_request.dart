import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_auth/sign_up_post_request.g.dart";

@JsonSerializable()
class SignUpPostRequest extends ApiModel {
  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "password")
  final String password;

  const SignUpPostRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  factory SignUpPostRequest.fromJson(Map<String, dynamic> json) =>
      _$SignUpPostRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignUpPostRequestToJson(this);
}
