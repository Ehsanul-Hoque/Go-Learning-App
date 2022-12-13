import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_auth/edit_profile_post_request.g.dart";

@JsonSerializable()
class EditProfilePostRequest extends ApiModel {
  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "address")
  String address;

  @JsonKey(name: "phone")
  String phone;

  @JsonKey(name: "institution")
  String institution;

  @JsonKey(name: "class")
  String selectedClass;

  @JsonKey(name: "photo")
  String photo;

  EditProfilePostRequest({
    required this.name,
    required this.address,
    required this.phone,
    required this.institution,
    required this.selectedClass,
    required this.photo,
  });

  factory EditProfilePostRequest.blank() {
    return EditProfilePostRequest(
      name: "",
      address: "",
      phone: "",
      institution: "",
      selectedClass: "",
      photo: "",
    );
  }

  factory EditProfilePostRequest.fromJson(Map<String, dynamic> json) =>
      _$EditProfilePostRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EditProfilePostRequestToJson(this);
}
