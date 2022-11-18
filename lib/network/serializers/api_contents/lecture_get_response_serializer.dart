import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/models/api_contents/lecture_get_response_model.dart";
import "package:app/network/models/api_contents/lecture_timestamp_response_model.dart";
import "package:app/network/serializers/api_contents/lecture_timestamp_response_serializer.dart";
import "package:app/network/serializers/serializer_helper.dart";
import "package:app/serializers/serializer.dart";

class LectureGetResponseSerializer extends Serializer<LectureGetResponseModel> {
  const LectureGetResponseSerializer();

  @override
  LectureGetResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const LectureGetResponseModel();

    return LectureGetResponseModel(
      sId: json["_id"],
      contentType:
          CourseContentType.valueOf((json["content_type"] as String?) ?? ""),
      publicToAccess: json["public_to_access"],
      locked: json["locked"],
      title: json["title"],
      moduleId: json["module_id"],
      serial: json["serial"],
      timeStamp:
          SerializerHelper.jsonToModelList<LectureTimeStampResponseModel>(
        json["time_stamp"],
        const LectureTimeStampResponseSerializer(),
      ),
      courseId: json["course_id"],
      link: json["link"],
      iV: json["__v"],
    );
  }

  @override
  Map<String, dynamic> toJson(LectureGetResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["content_type"] =
        (serializable.contentType ?? CourseContentType.unknown).name;
    data["public_to_access"] = serializable.publicToAccess;
    data["locked"] = serializable.locked;
    data["title"] = serializable.title;
    data["module_id"] = serializable.moduleId;
    data["serial"] = serializable.serial;
    data["time_stamp"] =
        SerializerHelper.modelToJsonList<LectureTimeStampResponseModel>(
      serializable.timeStamp,
      const LectureTimeStampResponseSerializer(),
    );
    data["course_id"] = serializable.courseId;
    data["link"] = serializable.link;
    data["__v"] = serializable.iV;

    return data;
  }
}
