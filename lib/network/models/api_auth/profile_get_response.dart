import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";
import "package:objectbox/objectbox.dart";

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
@Entity()
class ProfileGetResponseData extends ApiModel {
  @JsonKey(ignore: true)
  @Id()
  int boxId;

  @JsonKey(ignore: true)
  String? xAccessToken;

  @JsonKey(name: "_id")
  String? sId;

  @JsonKey(name: "institution")
  String? institution;

  @JsonKey(name: "enrolled_courses")
  List<String?>? enrolledCourses;

  @JsonKey(name: "verified")
  bool? verified;

  @JsonKey(name: "fingerprint_token")
  List<String?>? fingerprintToken;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "createdAt")
  String? createdAt;

  @JsonKey(name: "updatedAt")
  String? updatedAt;

  @JsonKey(name: "__v")
  int? iV;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "class")
  String? selectedClass;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "photo")
  String? photo;

  @JsonKey(name: "user_type")
  String? userType;

  ProfileGetResponseData({
    this.boxId = 0,
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
