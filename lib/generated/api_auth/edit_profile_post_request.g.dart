// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_auth/edit_profile_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProfilePostRequest _$EditProfilePostRequestFromJson(
        Map<String, dynamic> json) =>
    EditProfilePostRequest(
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      institution: json['institution'] as String,
      selectedClass: json['class'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$EditProfilePostRequestToJson(
        EditProfilePostRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
      'institution': instance.institution,
      'class': instance.selectedClass,
      'photo': instance.photo,
    };
