// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_info_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticInfoGetResponse _$StaticInfoGetResponseFromJson(
        Map<String, dynamic> json) =>
    StaticInfoGetResponse(
      sId: json['_id'] as String?,
      rocketNumber: json['rocket_number'] as String?,
      bkashNumber: json['bkash_number'] as String?,
      nagadNumber: json['nagad_number'] as String?,
      banner:
          (json['banner'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      youtubeVideo: (json['youtube_video'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      testimonial: (json['testimonial'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SigrTestimonial.fromJson(e as Map<String, dynamic>))
          .toList(),
      announcement: (json['announcement'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SigrAnnouncement.fromJson(e as Map<String, dynamic>))
          .toList(),
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$StaticInfoGetResponseToJson(
        StaticInfoGetResponse instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'rocket_number': instance.rocketNumber,
      'bkash_number': instance.bkashNumber,
      'nagad_number': instance.nagadNumber,
      'banner': instance.banner,
      'youtube_video': instance.youtubeVideo,
      'testimonial': instance.testimonial,
      'announcement': instance.announcement,
      '__v': instance.iV,
    };

SigrTestimonial _$SigrTestimonialFromJson(Map<String, dynamic> json) =>
    SigrTestimonial(
      sId: json['_id'] as String?,
      text: json['text'] as String?,
      photo: json['photo'] as String?,
      link: json['link'] as String?,
      name: json['name'] as String?,
      designation: json['designation'] as String?,
    );

Map<String, dynamic> _$SigrTestimonialToJson(SigrTestimonial instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'text': instance.text,
      'photo': instance.photo,
      'link': instance.link,
      'name': instance.name,
      'designation': instance.designation,
    };

SigrAnnouncement _$SigrAnnouncementFromJson(Map<String, dynamic> json) =>
    SigrAnnouncement(
      isVisible: json['is_visible'] as bool?,
      sId: json['_id'] as String?,
      text: json['text'] as String?,
      photo: json['photo'] as String?,
      link: json['link'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$SigrAnnouncementToJson(SigrAnnouncement instance) =>
    <String, dynamic>{
      'is_visible': instance.isVisible,
      '_id': instance.sId,
      'text': instance.text,
      'photo': instance.photo,
      'link': instance.link,
      'title': instance.title,
    };
