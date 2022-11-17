import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/serializers/serializer.dart";

class ContentTreeGetResponseSerializer
    extends Serializer<ContentTreeGetResponseModel> {
  const ContentTreeGetResponseSerializer();

  @override
  ContentTreeGetResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const ContentTreeGetResponseModel();

    return ContentTreeGetResponseModel(
      haveFullAccess: json["have_full_access"],
      module: (json["module"] as List<dynamic>?)
          ?.map((dynamic module) => module as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? module) => (module == null)
                ? null
                : const CtgrModuleSerializer().fromJson(module),
          )
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(ContentTreeGetResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["have_full_access"] = serializable.haveFullAccess;
    data["module"] = serializable.module
        ?.map(
          (CtgrModuleModel? module) => (module == null)
              ? null
              : const CtgrModuleSerializer().toJson(module),
        )
        .toList();

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
      contents: (json["contents"] as List<dynamic>?)
          ?.map((dynamic content) => content as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? content) => (content == null)
                ? null
                : const CtgrContentsSerializer().fromJson(content),
          )
          .toList(),
      subs: (json["subs"] as List<dynamic>?)
          ?.map((dynamic module) => module as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? module) => (module == null)
                ? null
                : const CtgrModuleSerializer().fromJson(module),
          )
          .toList(),
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
    data["contents"] = serializable.contents
        ?.map(
          (CtgrContentsModel? content) => (content == null)
              ? null
              : const CtgrContentsSerializer().toJson(content),
        )
        .toList();
    data["subs"] = serializable.subs
        ?.map(
          (CtgrModuleModel? module) => (module == null)
              ? null
              : const CtgrModuleSerializer().toJson(module),
        )
        .toList();

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
      contentType: json["content_type"],
      publicToAccess: json["public_to_access"],
      locked: json["locked"],
      title: json["title"],
      moduleId: json["module_id"],
      serial: json["serial"],
      timeStamp: (json["time_stamp"] as List<dynamic>?)
          ?.map((dynamic timeStamp) => timeStamp as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? timeStamp) => (timeStamp == null)
                ? null
                : const CtgrVideoTimeStampSerializer().fromJson(timeStamp),
          )
          .toList(),
      courseId: json["course_id"],
      iV: json["__v"],
    );
  }

  @override
  Map<String, dynamic> toJson(CtgrContentsModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["content_type"] = serializable.contentType;
    data["public_to_access"] = serializable.publicToAccess;
    data["locked"] = serializable.locked;
    data["title"] = serializable.title;
    data["module_id"] = serializable.moduleId;
    data["serial"] = serializable.serial;
    data["time_stamp"] = serializable.timeStamp
        ?.map(
          (CtgrVideoTimeStampModel? timeStamp) => (timeStamp == null)
              ? null
              : const CtgrVideoTimeStampSerializer().toJson(timeStamp),
        )
        .toList();
    data["course_id"] = serializable.courseId;
    data["__v"] = serializable.iV;

    return data;
  }
}

class CtgrVideoTimeStampSerializer extends Serializer<CtgrVideoTimeStampModel> {
  const CtgrVideoTimeStampSerializer();

  @override
  CtgrVideoTimeStampModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const CtgrVideoTimeStampModel();

    return CtgrVideoTimeStampModel(
      sId: json["_id"],
      title: json["title"],
      time: json["time"],
    );
  }

  @override
  Map<String, dynamic> toJson(CtgrVideoTimeStampModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["_id"] = serializable.sId;
    data["title"] = serializable.title;
    data["time"] = serializable.time;

    return data;
  }
}
