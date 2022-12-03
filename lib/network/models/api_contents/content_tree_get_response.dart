import "package:app/network/models/api_contents/lecture_get_response_timestamp.dart";
import "package:app/network/models/api_model.dart";
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

  @JsonKey(name: "time_stamp")
  final List<LectureGetResponseTimeStamp?>? timeStamp;

  @JsonKey(name: "course_id")
  final String? courseId;

  @JsonKey(name: "__v")
  final int? iV;

  const ContentTreeGetResponseContents({
    this.sId,
    this.contentType,
    this.publicToAccess,
    this.locked,
    this.title,
    this.moduleId,
    this.serial,
    this.timeStamp,
    this.courseId,
    this.iV,
  });

  factory ContentTreeGetResponseContents.fromJson(Map<String, dynamic> json) =>
      _$ContentTreeGetResponseContentsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ContentTreeGetResponseContentsToJson(this);
}
