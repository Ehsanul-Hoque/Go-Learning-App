import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_auth/profile_get_response_serializer.dart";

class ProfileGetResponseModel extends BaseApiModel {
  final String? sId;
  final String? institution;
  final List<String?>? enrolledCourses;
  final bool? verified;
  final List<String?>? fingerprintToken;
  final String? email;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final int? iV;
  final String? address;
  final String? selectedClass;
  final String? phone;
  final String? photo;
  final String? userType;

  const ProfileGetResponseModel({
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
  }) : super(serializer: const ProfileGetResponseSerializer());

  @override
  String get className => "ProfileGetResponseModel";
}
