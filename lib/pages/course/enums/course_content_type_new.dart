import "package:app/app_config/resources.dart";
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/material.dart" show Color, IconData;

class CourseContentTypeNew {
  static CourseContentTypeNew lecture = CourseContentTypeNew(
    "lecture",
    CupertinoIcons.play_arrow_solid,
    Res.color.videoItemIcon,
  );

  /*static CourseContentTypeNew quiz = CourseContentTypeNew(
    "quiz",
    CupertinoIcons.pencil_outline,
    Res.color.quizItemIcon,
  );*/

  static CourseContentTypeNew resource = CourseContentTypeNew(
    "resource",
    CupertinoIcons.doc_text,
    Res.color.resourceItemIcon,
  );

  static CourseContentTypeNew unknown = CourseContentTypeNew(
    "unknown",
    CupertinoIcons.exclamationmark_circle,
    Res.color.unknownItemIcon,
  );

  /// All-argument constructor
  const CourseContentTypeNew(this.name, this.iconData, this.color);

  final String name;
  final IconData iconData;
  final Color color;

  static List<CourseContentTypeNew> values = <CourseContentTypeNew>[
    lecture,
    resource,
    unknown,
  ];

  static CourseContentTypeNew valueOf(String? name) {
    if (name == null) return CourseContentTypeNew.unknown;

    return CourseContentTypeNew.values.firstWhere(
      (CourseContentTypeNew element) => element.name == name,
      orElse: () => CourseContentTypeNew.unknown,
    );
  }
}
