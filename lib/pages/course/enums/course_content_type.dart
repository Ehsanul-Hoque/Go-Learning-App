import "package:app/app_config/resources.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:app/pages/course/workers/lecture_worker.dart";
import "package:flutter/cupertino.dart" show Color, CupertinoIcons, IconData;

typedef GetResponseFunction = NetworkCallStatus Function(
  ContentApiNotifier? apiNotifier,
  ContentTreeGetResponseContents? content,
);

class CourseContentType {
  /// Lecture type
  static CourseContentType lecture = CourseContentType(
    name: "lecture",
    iconData: CupertinoIcons.play_arrow_solid,
    color: Res.color.videoItemIcon,
    worker: LectureWorker(),
    getResponseCallback: (
      ContentApiNotifier? apiNotifier,
      ContentTreeGetResponseContents? content,
    ) =>
        apiNotifier?.lectureGetResponse(content?.sId).callStatus ??
        NetworkCallStatus.none,
  );

  /// Quiz type
  static CourseContentType quiz = CourseContentType(
    name: "quiz",
    iconData: CupertinoIcons.pencil_outline,
    color: Res.color.quizItemIcon,
    isAvailable: false,
  );

  /// Resource type
  static CourseContentType resource = CourseContentType(
    name: "resource",
    iconData: CupertinoIcons.doc_text,
    color: Res.color.resourceItemIcon,
    isAvailable: false,
  );

  /// Unknown type
  static CourseContentType unknown = CourseContentType(
    name: "unknown",
    iconData: CupertinoIcons.exclamationmark_circle,
    color: Res.color.unknownItemIcon,
  );

  /// All-argument constructor
  const CourseContentType({
    required this.name,
    required this.iconData,
    required this.color,
    this.worker,
    this.getResponseCallback,
    this.isAvailable = true,
  });

  final String name;
  final IconData iconData;
  final Color color;
  final ContentWorker? worker;
  final GetResponseFunction? getResponseCallback;
  final bool isAvailable;

  /// Field to get all values
  static List<CourseContentType> values = <CourseContentType>[
    lecture,
    quiz,
    resource,
    unknown,
  ];

  /// Method to get content type from name
  static CourseContentType valueOf(String? name) {
    if (name == null) return CourseContentType.unknown;

    return CourseContentType.values.firstWhere(
      (CourseContentType element) => element.name == name,
      orElse: () => CourseContentType.unknown,
    );
  }
}
