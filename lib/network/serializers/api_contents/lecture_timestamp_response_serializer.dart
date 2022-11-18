import "package:app/network/models/api_contents/lecture_timestamp_response_model.dart";
import "package:app/serializers/serializer.dart";

class LectureTimeStampResponseSerializer
    extends Serializer<LectureTimeStampResponseModel> {
  const LectureTimeStampResponseSerializer();

  @override
  LectureTimeStampResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const LectureTimeStampResponseModel();

    return LectureTimeStampResponseModel(
      sId: json["_id"],
      title: json["title"],
      time: json["time"],
    );
  }

  @override
  Map<String, dynamic> toJson(LectureTimeStampResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["title"] = serializable.title;
    data["time"] = serializable.time;

    return data;
  }
}
