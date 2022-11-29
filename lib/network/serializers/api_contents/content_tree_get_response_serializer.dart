import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/network/models/api_contents/lecture_timestamp_response_model.dart";
import "package:app/network/serializers/api_contents/lecture_timestamp_response_serializer.dart";
import "package:app/serializers/serializer_helper.dart";
import "package:app/serializers/serializer.dart";

class ContentTreeGetResponseSerializer
    extends Serializer<ContentTreeGetResponseModel> {
  const ContentTreeGetResponseSerializer();

  @override
  ContentTreeGetResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ContentTreeGetResponseModel();

    return ContentTreeGetResponseModel(
      haveFullAccess: json["have_full_access"],
      module: SerializerHelper.jsonToModelList<CtgrModuleModel>(
        json["module"],
        const CtgrModuleSerializer(),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(ContentTreeGetResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["have_full_access"] = serializable.haveFullAccess;
    data["module"] = SerializerHelper.modelToJsonList<CtgrModuleModel>(
      serializable.module,
      const CtgrModuleSerializer(),
    );

    return data;
  }
}

class CtgrModuleSerializer extends Serializer<CtgrModuleModel> {
  const CtgrModuleSerializer();

  @override
  CtgrModuleModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CtgrModuleModel();

    return CtgrModuleModel(
      sId: json["_id"],
      parentModuleId: json["parent_module_id"],
      title: json["title"],
      serial: json["serial"],
      courseId: json["course_id"],
      iV: json["__v"],
      contents: SerializerHelper.jsonToModelList<CtgrContentsModel>(
        json["contents"],
        const CtgrContentsSerializer(),
      ),
      subs: SerializerHelper.jsonToModelList<CtgrModuleModel>(
        json["subs"],
        const CtgrModuleSerializer(),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(CtgrModuleModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["parent_module_id"] = serializable.parentModuleId;
    data["title"] = serializable.title;
    data["serial"] = serializable.serial;
    data["course_id"] = serializable.courseId;
    data["__v"] = serializable.iV;
    data["contents"] = SerializerHelper.modelToJsonList<CtgrContentsModel>(
      serializable.contents,
      const CtgrContentsSerializer(),
    );
    data["subs"] = SerializerHelper.modelToJsonList<CtgrModuleModel>(
      serializable.subs,
      const CtgrModuleSerializer(),
    );

    return data;
  }
}

class CtgrContentsSerializer extends Serializer<CtgrContentsModel> {
  const CtgrContentsSerializer();

  @override
  CtgrContentsModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CtgrContentsModel();

    return CtgrContentsModel(
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
      iV: json["__v"],
    );
  }

  @override
  Map<String, dynamic> toJson(CtgrContentsModel serializable) {
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
    data["__v"] = serializable.iV;

    return data;
  }
}
