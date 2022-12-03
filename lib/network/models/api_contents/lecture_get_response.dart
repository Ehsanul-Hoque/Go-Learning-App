import "package:app/network/models/api_contents/lecture_get_response_timestamp.dart";
import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_contents/lecture_get_response.g.dart";

@JsonSerializable()
class LectureGetResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "data")
  final List<LectureGetResponseData?>? data;

  LectureGetResponse({
    this.success,
    this.data,
  });

  factory LectureGetResponse.fromJson(Map<String, dynamic> json) =>
      _$LectureGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LectureGetResponseToJson(this);
}

@JsonSerializable()
class LectureGetResponseData extends ApiModel {
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

  @JsonKey(name: "link")
  final String? link;

  @JsonKey(name: "course_id")
  final String? courseId;

  @JsonKey(name: "__v")
  final int? iV;

  const LectureGetResponseData({
    this.sId,
    this.contentType,
    this.publicToAccess,
    this.locked,
    this.title,
    this.moduleId,
    this.serial,
    this.timeStamp,
    this.link,
    this.courseId,
    this.iV,
  });

  factory LectureGetResponseData.fromJson(Map<String, dynamic> json) =>
      _$LectureGetResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LectureGetResponseDataToJson(this);
}
