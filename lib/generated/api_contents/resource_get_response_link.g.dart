// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_contents/resource_get_response_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResourceGetResponseLink _$ResourceGetResponseLinkFromJson(
        Map<String, dynamic> json) =>
    ResourceGetResponseLink(
      sId: json['_id'] as String?,
      name: json['name'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$ResourceGetResponseLinkToJson(
        ResourceGetResponseLink instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'name': instance.name,
      'link': instance.link,
    };
