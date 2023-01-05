import "package:app/app_config/resources.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/course/workers/lecture_worker.dart";
import "package:app/pages/course/workers/quiz_worker.dart";
import "package:app/pages/course/workers/resource_worker.dart";
import "package:app/utils/typedefs.dart";
import "package:flutter/cupertino.dart" show Color, CupertinoIcons, IconData;

class CourseContentType {
  /// Lecture type
  static CourseContentType lecture = CourseContentType(
    name: "lecture",
    iconData: CupertinoIcons.play_arrow_solid,
    color: Res.color.videoItem,
    workerCreator: (_, ContentTreeGetResponseContents contentItem) =>
        LectureWorker(contentItem),
  );

  /// Quiz type
  static CourseContentType quiz = CourseContentType(
    name: "quiz",
    iconData: CupertinoIcons.pencil_outline,
    color: Res.color.quizItem,
    workerCreator: (
      CourseGetResponse? courseItem,
      ContentTreeGetResponseContents contentItem,
    ) =>
        QuizWorker(contentItem, courseItem),
  );

  /// Resource type
  static CourseContentType resource = CourseContentType(
    name: "resource",
    iconData: CupertinoIcons.doc_text,
    color: Res.color.resourceItem,
    workerCreator: (_, ContentTreeGetResponseContents contentItem) =>
        ResourceWorker(contentItem),
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
    this.workerCreator,
  });

  final String name;
  final IconData iconData;
  final Color color;
  final ContentWorkerCreator<Object>? workerCreator;

  /// Getter method to check if this type is available or not
  bool get isAvailable => workerCreator != null;

  /// Field to get all values.
  /// Must change this list if any static field in this class
  /// is added/modified/removed.
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
