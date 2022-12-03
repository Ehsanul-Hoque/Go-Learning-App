import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_auth/profile_get_response.g.dart";

@JsonSerializable()
class ProfileGetResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "data")
  final List<ProfileGetResponseData?>? data;

  ProfileGetResponse({
    this.success,
    this.data,
  });

  factory ProfileGetResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileGetResponseToJson(this);
}

@JsonSerializable()
class ProfileGetResponseData extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "institution")
  final String? institution;

  @JsonKey(name: "enrolled_courses")
  final List<String?>? enrolledCourses;

  @JsonKey(name: "verified")
  final bool? verified;

  @JsonKey(name: "fingerprint_token")
  final List<String?>? fingerprintToken;

  @JsonKey(name: "email")
  final String? email;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "createdAt")
  final String? createdAt;

  @JsonKey(name: "updatedAt")
  final String? updatedAt;

  @JsonKey(name: "__v")
  final int? iV;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "class")
  final String? selectedClass;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "user_type")
  final String? userType;

  const ProfileGetResponseData({
    this.sId,
    this.institution,
    this.enrolledCourses,
    this.verified,
    this.fingerprintToken,
    this.email,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.address,
    this.selectedClass,
    this.phone,
    this.photo,
    this.userType,
  });

  factory ProfileGetResponseData.fromJson(Map<String, dynamic> json) =>
      _$ProfileGetResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileGetResponseDataToJson(this);
}
