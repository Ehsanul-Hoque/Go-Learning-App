enum NetworkCallType {
  get("GET"),
  post("POST"),
  put("PUT");

  final String name;

  const NetworkCallType(this.name);

  static NetworkCallType valueOf(String name) {
    return NetworkCallType.values.firstWhere(
      (NetworkCallType element) => element.name == name,
      orElse: () => NetworkCallType.get,
    );
  }
}
