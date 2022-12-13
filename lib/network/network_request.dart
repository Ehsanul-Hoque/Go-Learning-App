import "package:app/network/enums/network_call_type.dart";

class NetworkRequest {
  /// Named constructor for GET request
  const NetworkRequest.get({
    required this.apiEndPoint,
    this.baseUrl,
    this.headers,
  })  : callType = NetworkCallType.get,
        body = null;

  /// Named constructor for POST request
  const NetworkRequest.post({
    required this.apiEndPoint,
    required this.body,
    this.baseUrl,
    this.headers,
  })  : assert(body != null),
        callType = NetworkCallType.post;

  /// Named constructor for PUT request
  const NetworkRequest.put({
    required this.apiEndPoint,
    required this.body,
    this.baseUrl,
    this.headers,
  })  : assert(body != null),
        callType = NetworkCallType.put;

  /// Network call method name (GET, POST etc)
  final NetworkCallType callType;

  /// API endpoint (without the base url part)
  final String apiEndPoint;

  /// API base url
  final String? baseUrl;

  /// Request headers
  final Map<String, String>? headers;

  /// Request body for POST/PUT requests
  final Map<String, dynamic>? body;
}
