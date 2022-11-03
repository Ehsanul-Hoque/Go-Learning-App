import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_static_info/static_info_get_response_serializer.dart";

class StaticInfoGetResponseModel extends BaseApiModel {
  final String? sId;
  final String? rocketNumber;
  final String? bkashNumber;
  final String? nagadNumber;
  final List<String?>? banner;
  final List<String?>? youtubeVideo;
  final List<SigrTestimonialModel?>? testimonial;
  final List<SigrAnnouncementModel?>? announcement;
  final int? iV;

  const StaticInfoGetResponseModel({
    this.sId,
    this.rocketNumber,
    this.bkashNumber,
    this.nagadNumber,
    this.banner,
    this.youtubeVideo,
    this.testimonial,
    this.announcement,
    this.iV,
  }) : super(serializer: const StaticInfoGetResponseSerializer());

  @override
  String get className => "StaticInfoResponseModel";
}

class SigrTestimonialModel extends BaseApiModel {
  final String? sId;
  final String? text;
  final String? photo;
  final String? link;
  final String? name;
  final String? designation;

  const SigrTestimonialModel({
    this.sId,
    this.text,
    this.photo,
    this.link,
    this.name,
    this.designation,
  }) : super(serializer: const SigrTestimonialSerializer());

  @override
  String get className => "SigrTestimonialModel";
}

class SigrAnnouncementModel extends BaseApiModel {
  final bool? isVisible;
  final String? sId;
  final String? text;
  final String? photo;
  final String? link;
  final String? title;

  const SigrAnnouncementModel({
    this.isVisible,
    this.sId,
    this.text,
    this.photo,
    this.link,
    this.title,
  }) : super(serializer: const SigrAnnouncementSerializer());

  @override
  String get className => "SigrAnnouncementModel";
}
