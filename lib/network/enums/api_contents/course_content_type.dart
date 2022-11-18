enum CourseContentType {
  lecture("lecture"),
  unknown("unknown");

  final String name;

  const CourseContentType(this.name);

  static CourseContentType valueOf(String name) {
    return CourseContentType.values.firstWhere(
      (CourseContentType element) => element.name == name,
      orElse: () => CourseContentType.unknown,
    );
  }
}
