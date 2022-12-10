import "package:app/network/enums/network_call_status.dart";
import "package:app/network/network_error.dart";
import "package:app/utils/utils.dart";
import "package:http/http.dart" as http;

class NetworkResponse<T> {
  /// Constructor to create a new response object
  NetworkResponse({
    this.callStatus = NetworkCallStatus.none,
    this.httpResponse,
    this.result,
    NetworkError? error,
  }) : _error = error;

  /// Network call current status (i.e. loading or success etc)
  NetworkCallStatus callStatus;

  /// HTTP response object
  http.Response? httpResponse;

  /// Dart object that is created from the HTTP response
  T? result;

  /// Error object
  NetworkError? _error;

  NetworkError? get error {
    if (_error != null) return _error;
    if (callStatus == NetworkCallStatus.failed) return NetworkError.general();
    return null;
  }

  set error(NetworkError? error) => _error = error;

  /// Getter to get the HTTP response status code
  int get statusCode => httpResponse?.statusCode ?? -1;

  /// Method to reset values
  void reset() {
    callStatus = NetworkCallStatus.none;
    httpResponse = null;
    result = null;
    error = null;
  }

  /// Method to copy from another response object
  void copyFrom(NetworkResponse<T> other) {
    callStatus = other.callStatus;
    httpResponse = other.httpResponse;
    result = other.result;
    error = other.error;
  }

  /// toString() method
  @override
  String toString() {
    return Utils.getModelString(
      runtimeType.toString(),
      <String, dynamic>{
        "callStatus": callStatus.name,
        "httpResponse": httpResponse.toString(),
        "result": "Instance of '${result.runtimeType.toString()}'",
        "error": error.toString(),
      },
    );
  }
}
