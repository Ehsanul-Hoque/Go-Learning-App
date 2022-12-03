// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/profile_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileGetResponse _$ProfileGetResponseFromJson(Map<String, dynamic> json) =>
    ProfileGetResponse(
      success: json['success'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ProfileGetResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProfileGetResponseToJson(ProfileGetResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data?.map((e) => e?.toJson()).toList(),
    };

ProfileGetResponseData _$ProfileGetResponseDataFromJson(
        Map<String, dynamic> json) =>
    ProfileGetResponseData(
      sId: json['_id'] as String?,
      institution: json['institution'] as String?,
      enrolledCourses: (json['enrolled_courses'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      verified: json['verified'] as bool?,
      fingerprintToken: (json['fingerprint_token'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      email: json['email'] as String?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['__v'] as int?,
      address: json['address'] as String?,
      selectedClass: json['class'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      userType: json['user_type'] as String?,
    );

Map<String, dynamic> _$ProfileGetResponseDataToJson(
        ProfileGetResponseData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'institution': instance.institution,
      'enrolled_courses': instance.enrolledCourses,
      'verified': instance.verified,
      'fingerprint_token': instance.fingerprintToken,
      'email': instance.email,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.iV,
      'address': instance.address,
      'class': instance.selectedClass,
      'phone': instance.phone,
      'photo': instance.photo,
      'user_type': instance.userType,
    };
