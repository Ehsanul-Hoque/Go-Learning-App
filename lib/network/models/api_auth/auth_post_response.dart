import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";
import "package:objectbox/objectbox.dart";

part "../../../generated/api_auth/auth_post_response.g.dart";

@JsonSerializable()
@Entity()
class AuthPostResponse extends ApiModel {
  @JsonKey(ignore: true)
  @Id()
  int boxId;

  @JsonKey(name: "x-access-token")
  String? xAccessToken;

  @JsonKey(name: "msg")
  @Transient()
  String? msg;

  AuthPostResponse({
    this.boxId = 0,
    this.xAccessToken,
    this.msg,
  });

  factory AuthPostResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthPostResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AuthPostResponseToJson(this);
}
