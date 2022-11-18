import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/models/api_contents/lecture_timestamp_response_model.dart";
import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_contents/content_tree_get_response_serializer.dart";

class ContentTreeGetResponseModel extends BaseApiModel {
  final bool? haveFullAccess;
  final List<CtgrModuleModel?>? module;

  const ContentTreeGetResponseModel({
    this.haveFullAccess,
    this.module,
  }) : super(serializer: const ContentTreeGetResponseSerializer());

  @override
  String get className => "ContentTreeGetResponseModel";
}

class CtgrModuleModel extends BaseApiModel {
  final String? sId;
  final String? parentModuleId;
  final String? title;
  final int? serial;
  final String? courseId;
  final int? iV;
  final List<CtgrContentsModel?>? contents;
  final List<CtgrModuleModel?>? subs;

  const CtgrModuleModel({
    this.sId,
    this.parentModuleId,
    this.title,
    this.serial,
    this.courseId,
    this.iV,
    this.contents,
    this.subs,
  }) : super(serializer: const CtgrModuleSerializer());

  @override
  String get className => "CtgrModuleModel";
}

class CtgrContentsModel extends BaseApiModel {
  final String? sId;
  final CourseContentType? contentType;
  final bool? publicToAccess;
  final bool? locked;
  final String? title;
  final String? moduleId;
  final int? serial;
  final List<LectureTimeStampResponseModel?>? timeStamp;
  final String? courseId;
  final int? iV;

  const CtgrContentsModel({
    this.sId,
    this.contentType,
    this.publicToAccess,
    this.locked,
    this.title,
    this.moduleId,
    this.serial,
    this.timeStamp,
    this.courseId,
    this.iV,
  }) : super(serializer: const CtgrContentsSerializer());

  @override
  String get className => "CtgrContentsModel";
}
