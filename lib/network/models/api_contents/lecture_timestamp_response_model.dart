import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_contents/lecture_timestamp_response_serializer.dart";

class LectureTimeStampResponseModel extends BaseApiModel {
  final String? sId;
  final String? title;
  final String? time;

  const LectureTimeStampResponseModel({
    this.sId,
    this.title,
    this.time,
  }) : super(serializer: const LectureTimeStampResponseSerializer());

  @override
  String get className => "LectureTimeStampResponseModel";
}
