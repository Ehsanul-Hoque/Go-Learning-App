import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";
import "package:objectbox/objectbox.dart";

part "../../../generated/api_auth/sign_in_post_response.g.dart";

@JsonSerializable()
@Entity()
class SignInPostResponse extends ApiModel {
  @JsonKey(ignore: true)
  @Id()
  int boxId;

  @JsonKey(name: "x-access-token")
  String? xAccessToken;

  @JsonKey(name: "msg")
  @Transient()
  String? msg;

  SignInPostResponse({
    this.boxId = 0,
    this.xAccessToken,
    this.msg,
  });

  factory SignInPostResponse.fromJson(Map<String, dynamic> json) =>
      _$SignInPostResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SignInPostResponseToJson(this);
}
