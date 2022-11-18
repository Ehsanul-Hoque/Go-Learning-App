import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/models/api_contents/lecture_timestamp_response_model.dart";
import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_contents/lecture_get_response_serializer.dart";

class LectureGetResponseModel extends BaseApiModel {
  final String? sId;
  final CourseContentType? contentType;
  final bool? publicToAccess;
  final bool? locked;
  final String? title;
  final String? moduleId;
  final int? serial;
  final List<LectureTimeStampResponseModel?>? timeStamp;
  final String? link;
  final String? courseId;
  final int? iV;

  const LectureGetResponseModel({
    this.sId,
    this.contentType,
    this.publicToAccess,
    this.locked,
    this.title,
    this.moduleId,
    this.serial,
    this.timeStamp,
    this.link,
    this.courseId,
    this.iV,
  }) : super(serializer: const LectureGetResponseSerializer());

  @override
  String get className => "LectureGetResponseModel";
}
