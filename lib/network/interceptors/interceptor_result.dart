import "package:app/network/network_error.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:http/http.dart" as http;

class RequestInterceptorResult {
  final NetworkRequest? request;
  final NetworkError? error;

  RequestInterceptorResult({
    this.request,
    this.error,
  });
}

class RawResponseInterceptorResult {
  final http.Response? httpResponse;
  final NetworkError? error;

  RawResponseInterceptorResult({
    this.httpResponse,
    this.error,
  });
}

class ProcessedResponseInterceptorResult<DO> {
  final NetworkResponse<DO> response;
  final NetworkError? error;

  ProcessedResponseInterceptorResult({
    required this.response,
    this.error,
  });
}
