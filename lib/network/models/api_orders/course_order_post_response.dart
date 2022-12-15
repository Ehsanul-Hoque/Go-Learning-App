import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_orders/course_order_post_response.g.dart";

@JsonSerializable()
class CourseOrderPostResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "msg")
  final String? msg;

  CourseOrderPostResponse({
    this.success,
    this.msg,
  });

  factory CourseOrderPostResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseOrderPostResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CourseOrderPostResponseToJson(this);
}
