class NetworkClient {
  final String baseUrl;
  final Map<String, String> headers;

  const NetworkClient({
    this.baseUrl = "",
    this.headers = const <String, String>{},
  });
}
