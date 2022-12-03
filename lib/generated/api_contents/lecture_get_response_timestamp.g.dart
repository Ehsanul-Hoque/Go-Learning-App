// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_contents/lecture_get_response_timestamp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LectureGetResponseTimeStamp _$LectureGetResponseTimeStampFromJson(
        Map<String, dynamic> json) =>
    LectureGetResponseTimeStamp(
      sId: json['_id'] as String?,
      title: json['title'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$LectureGetResponseTimeStampToJson(
        LectureGetResponseTimeStamp instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'title': instance.title,
      'time': instance.time,
    };
