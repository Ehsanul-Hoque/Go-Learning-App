import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_auth/edit_profile_post_response.g.dart";

@JsonSerializable()
class EditProfilePostResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "msg")
  final String? msg;

  @JsonKey(name: "data")
  final bool? data;

  EditProfilePostResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory EditProfilePostResponse.fromJson(Map<String, dynamic> json) =>
      _$EditProfilePostResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EditProfilePostResponseToJson(this);
}
