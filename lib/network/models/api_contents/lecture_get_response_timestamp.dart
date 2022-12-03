import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_contents/lecture_get_response_timestamp.g.dart";

@JsonSerializable()
class LectureGetResponseTimeStamp extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "time")
  final String? time;

  const LectureGetResponseTimeStamp({
    this.sId,
    this.title,
    this.time,
  });

  factory LectureGetResponseTimeStamp.fromJson(Map<String, dynamic> json) =>
      _$LectureGetResponseTimeStampFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LectureGetResponseTimeStampToJson(this);
}
