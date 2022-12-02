import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "static_info_get_response.g.dart";

@JsonSerializable()
class StaticInfoGetResponse extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "rocket_number")
  final String? rocketNumber;

  @JsonKey(name: "bkash_number")
  final String? bkashNumber;

  @JsonKey(name: "nagad_number")
  final String? nagadNumber;

  @JsonKey(name: "banner")
  final List<String?>? banner;

  @JsonKey(name: "youtube_video")
  final List<String?>? youtubeVideo;

  @JsonKey(name: "testimonial")
  final List<SigrTestimonial?>? testimonial;

  @JsonKey(name: "announcement")
  final List<SigrAnnouncement?>? announcement;

  @JsonKey(name: "__v")
  final int? iV;

  const StaticInfoGetResponse({
    this.sId,
    this.rocketNumber,
    this.bkashNumber,
    this.nagadNumber,
    this.banner,
    this.youtubeVideo,
    this.testimonial,
    this.announcement,
    this.iV,
  });

  factory StaticInfoGetResponse.fromJson(Map<String, dynamic> json) =>
      _$StaticInfoGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StaticInfoGetResponseToJson(this);

  @override
  String get className => "StaticInfoGetResponse";
}

@JsonSerializable()
class SigrTestimonial extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "text")
  final String? text;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "link")
  final String? link;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "designation")
  final String? designation;

  const SigrTestimonial({
    this.sId,
    this.text,
    this.photo,
    this.link,
    this.name,
    this.designation,
  });

  factory SigrTestimonial.fromJson(Map<String, dynamic> json) =>
      _$SigrTestimonialFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SigrTestimonialToJson(this);

  @override
  String get className => "SigrTestimonial";
}

@JsonSerializable()
class SigrAnnouncement extends ApiModel {
  @JsonKey(name: "is_visible")
  final bool? isVisible;

  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "text")
  final String? text;

  @JsonKey(name: "photo")
  final String? photo;

  @JsonKey(name: "link")
  final String? link;

  @JsonKey(name: "title")
  final String? title;

  const SigrAnnouncement({
    this.isVisible,
    this.sId,
    this.text,
    this.photo,
    this.link,
    this.title,
  });

  factory SigrAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$SigrAnnouncementFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SigrAnnouncementToJson(this);

  @override
  String get className => "SigrAnnouncement";
}
