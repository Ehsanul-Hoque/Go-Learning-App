import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_contents/resource_get_response.g.dart";

@JsonSerializable()
class ResourceGetResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  @JsonKey(name: "data")
  final List<ResourceGetResponseData?>? data;

  ResourceGetResponse({
    this.success,
    this.data,
  });

  factory ResourceGetResponse.fromJson(Map<String, dynamic> json) =>
      _$ResourceGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResourceGetResponseToJson(this);
}

@JsonSerializable()
class ResourceGetResponseData extends ApiModel {
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

  @JsonKey(name: "link")
  final List<ResourceGetResponseLink?>? link;

  @JsonKey(name: "course_id")
  final String? courseId;

  @JsonKey(name: "__v")
  final int? iV;

  const ResourceGetResponseData({
    this.sId,
    this.contentType,
    this.publicToAccess,
    this.locked,
    this.title,
    this.moduleId,
    this.serial,
    this.link,
    this.courseId,
    this.iV,
  });

  factory ResourceGetResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResourceGetResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResourceGetResponseDataToJson(this);
}

@JsonSerializable()
class ResourceGetResponseLink extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "link")
  final String? link;

  ResourceGetResponseLink({
    this.sId,
    this.name,
    this.link,
  });

  factory ResourceGetResponseLink.fromJson(Map<String, dynamic> json) =>
      _$ResourceGetResponseLinkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResourceGetResponseLinkToJson(this);
}
