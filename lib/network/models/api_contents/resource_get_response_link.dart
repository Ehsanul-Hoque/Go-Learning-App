import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_contents/resource_get_response_link.g.dart";

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
