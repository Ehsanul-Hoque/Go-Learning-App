import "package:app/network/models/api_static_info/static_info_get_response_model.dart";
import "package:app/serializers/serializer.dart";

class StaticInfoGetResponseSerializer
    extends Serializer<StaticInfoGetResponseModel> {
  const StaticInfoGetResponseSerializer();

  @override
  StaticInfoGetResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const StaticInfoGetResponseModel();

    return StaticInfoGetResponseModel(
      sId: json["_id"],
      rocketNumber: json["rocket_number"],
      bkashNumber: json["bkash_number"],
      nagadNumber: json["nagad_number"],
      banner: json["banner"].cast<String>(),
      youtubeVideo: (json["youtube_video"] as List<dynamic>?)
          ?.map((dynamic item) => item as String?)
          .toList(),
      testimonial: (json["testimonial"] as List<dynamic>?)
          ?.map((dynamic category) => category as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? item) => (item == null)
                ? null
                : const SigrTestimonialSerializer().fromJson(item),
          )
          .toList(),
      announcement: (json["announcement"] as List<dynamic>?)
          ?.map((dynamic category) => category as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? item) => (item == null)
                ? null
                : const SigrAnnouncementSerializer().fromJson(item),
          )
          .toList(),
      iV: json["__v"],
    );
  }

  @override
  Map<String, dynamic> toJson(StaticInfoGetResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["rocket_number"] = serializable.rocketNumber;
    data["bkash_number"] = serializable.bkashNumber;
    data["nagad_number"] = serializable.nagadNumber;
    data["banner"] = serializable.banner;
    data["youtube_video"] = serializable.youtubeVideo;
    data["testimonial"] = serializable.testimonial
        ?.map(
          (SigrTestimonialModel? testimonial) => (testimonial == null)
              ? null
              : const SigrTestimonialSerializer().toJson(testimonial),
        )
        .toList();
    data["announcement"] = serializable.announcement
        ?.map(
          (SigrAnnouncementModel? announcement) => (announcement == null)
              ? null
              : const SigrAnnouncementSerializer().toJson(announcement),
        )
        .toList();
    data["__v"] = serializable.iV;

    return data;
  }
}

class SigrTestimonialSerializer extends Serializer<SigrTestimonialModel> {
  const SigrTestimonialSerializer();

  @override
  SigrTestimonialModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SigrTestimonialModel();

    return SigrTestimonialModel(
      sId: json["_id"],
      text: json["text"],
      photo: json["photo"],
      link: json["link"],
      name: json["name"],
      designation: json["designation"],
    );
  }

  @override
  Map<String, dynamic> toJson(SigrTestimonialModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["text"] = serializable.text;
    data["photo"] = serializable.photo;
    data["link"] = serializable.link;
    data["name"] = serializable.name;
    data["designation"] = serializable.designation;

    return data;
  }
}

class SigrAnnouncementSerializer extends Serializer<SigrAnnouncementModel> {
  const SigrAnnouncementSerializer();

  @override
  SigrAnnouncementModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SigrAnnouncementModel();

    return SigrAnnouncementModel(
      isVisible: json["is_visible"],
      sId: json["_id"],
      text: json["text"],
      photo: json["photo"],
      link: json["link"],
      title: json["title"],
    );
  }

  @override
  Map<String, dynamic> toJson(SigrAnnouncementModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["is_visible"] = serializable.isVisible;
    data["_id"] = serializable.sId;
    data["text"] = serializable.text;
    data["photo"] = serializable.photo;
    data["link"] = serializable.link;
    data["title"] = serializable.title;

    return data;
  }
}
