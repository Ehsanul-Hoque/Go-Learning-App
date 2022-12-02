import "package:app/network/models/api_auth/profile_get_response_model.dart";
import "package:app/serializers/serializer.dart";
import "package:app/serializers/serializer_helper.dart";

class ProfileGetResponseSerializer extends Serializer<ProfileGetResponseModel> {
  const ProfileGetResponseSerializer();

  @override
  ProfileGetResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ProfileGetResponseModel();

    return ProfileGetResponseModel(
      sId: json["_id"],
      institution: json["institution"],
      enrolledCourses:
          SerializerHelper.jsonToTypedList<String>(json["enrolled_courses"]),
      verified: json["verified"],
      fingerprintToken:
          SerializerHelper.jsonToTypedList<String>(json["fingerprint_token"]),
      email: json["email"],
      name: json["name"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      iV: json["__v"],
      address: json["address"],
      selectedClass: json["class"],
      phone: json["phone"],
      photo: json["photo"],
      userType: json["user_type"],
    );
  }

  @override
  Map<String, dynamic> toJson(ProfileGetResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["institution"] = serializable.institution;
    data["enrolled_courses"] = serializable.enrolledCourses;
    data["verified"] = serializable.verified;
    data["fingerprint_token"] = serializable.fingerprintToken;
    data["email"] = serializable.email;
    data["name"] = serializable.name;
    data["createdAt"] = serializable.createdAt;
    data["updatedAt"] = serializable.updatedAt;
    data["__v"] = serializable.iV;
    data["address"] = serializable.address;
    data["class"] = serializable.selectedClass;
    data["phone"] = serializable.phone;
    data["photo"] = serializable.photo;
    data["user_type"] = serializable.userType;

    return data;
  }
}
