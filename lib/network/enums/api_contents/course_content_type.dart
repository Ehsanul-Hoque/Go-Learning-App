enum CourseContentType {
  lecture("lecture"),
  unknown("unknown");

  final String name;

  const CourseContentType(this.name);

  static CourseContentType valueOf(String? name) {
    if (name == null) return CourseContentType.unknown;

    return CourseContentType.values.firstWhere(
      (CourseContentType element) => element.name == name,
      orElse: () => CourseContentType.unknown,
    );
  }
}
