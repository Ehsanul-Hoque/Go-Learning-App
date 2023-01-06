import "package:app/network/models/api_contents/lecture_get_response_timestamp.dart";
import "package:app/network/models/api_contents/resource_get_response_link.dart";
import "package:app/network/models/api_model.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_contents/content_tree_get_response.g.dart";

@JsonSerializable()
class ContentTreeGetResponse extends ApiModel {
  @JsonKey(name: "have_full_access")
  final bool? haveFullAccess;

  @JsonKey(name: "module")
  final List<ContentTreeGetResponseModule?>? module;

  const ContentTreeGetResponse({
    this.haveFullAccess,
    this.module,
  });

  factory ContentTreeGetResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentTreeGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentTreeGetResponseToJson(this);
}

@JsonSerializable()
class ContentTreeGetResponseModule extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "parent_module_id")
  final String? parentModuleId;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "serial")
  final int? serial;

  @JsonKey(name: "course_id")
  final String? courseId;

  @JsonKey(name: "__v")
  final int? iV;

  @JsonKey(name: "contents")
  final List<ContentTreeGetResponseContents?>? contents;

  @JsonKey(name: "subs")
  final List<ContentTreeGetResponseModule?>? subs;

  const ContentTreeGetResponseModule({
    this.sId,
    this.parentModuleId,
    this.title,
    this.serial,
    this.courseId,
    this.iV,
    this.contents,
    this.subs,
  });

  factory ContentTreeGetResponseModule.fromJson(Map<String, dynamic> json) =>
      _$ContentTreeGetResponseModuleFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentTreeGetResponseModuleToJson(this);
}

@JsonSerializable()
class ContentTreeGetResponseContents extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "content_type")
  final String? contentType;

  @JsonKey(name: "public_to_access")
  final bool? publicToAccess;

  @JsonKey(name: "locked")
  final bool? locked;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "module_id")
  final String? moduleId;

  @JsonKey(name: "serial")
  final int? serial;

  /// Only for lecture type contents
  @JsonKey(name: "time_stamp")
  final List<LectureGetResponseTimeStamp?>? timeStamp;

  /// Only for lecture or resource type contents.
  /// For lecture types, this variable will contain a string value.
  /// For resource types, this variable will contain a
  /// [ResourceGetResponseLink] type.
  /// DO NOT USE this field to get link.
  /// Use [getLectureVideoLink] method to get lecture video link
  /// and [getResourceLink] method to get resource link.
  @JsonKey(name: "link")
  final Object? link;

  /// Only for quiz type contents
  @JsonKey(name: "questions")
  final List<String?>? questions;

  /// Only for quiz type contents
  @JsonKey(name: "duration")
  final int? durationInMinutes;

  /// Only for quiz type contents
  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "course_id")
  final String? courseId;

  @JsonKey(name: "__v")
  final int? iV;

  /// Only for lecture type contents
  @JsonKey(ignore: true)
  final String? lectureThumbnail;

  const ContentTreeGetResponseContents({
    this.sId,
    this.contentType,
    this.publicToAccess,
    this.locked,
    this.title,
    this.moduleId,
    this.serial,
    this.timeStamp,
    this.link,
    this.questions,
    this.durationInMinutes,
    this.description,
    this.courseId,
    this.iV,
    this.lectureThumbnail,
  });

  factory ContentTreeGetResponseContents.fromJson(Map<String, dynamic> json) =>
      _$ContentTreeGetResponseContentsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentTreeGetResponseContentsToJson(this);

  bool get isPreviewContent => (sId ?? "").trim().isEmpty;

  bool get isAccessibleQuizContent =>
      (questions ?? <String?>[]).getNonNulls().isNotEmpty &&
      durationInMinutes != null;

  String? getLectureVideoLink() {
    try {
      return link as String?;
    } catch (e) {
      return null;
    }
  }

  List<ResourceGetResponseLink?>? getResourceLink() {
    try {
      return (link as List<dynamic>?)?.map((Object? e) {
        return e == null
            ? null
            : ResourceGetResponseLink.fromJson(
                e as Map<String, dynamic>,
              );
      }).toList();
    } catch (e) {
      return null;
    }
  }

  bool isActuallyLocked(bool hasCourseEnrolled) {
    bool contentLocked = locked ?? false;
    bool contentPublic = publicToAccess ?? false;
    bool actuallyLocked = true;

    if (hasCourseEnrolled) {
      actuallyLocked = contentLocked;
    } else {
      actuallyLocked = !contentPublic || contentLocked;
    }

    return actuallyLocked;
  }
}
