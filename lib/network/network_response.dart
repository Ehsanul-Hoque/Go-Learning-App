import "package:app/network/enums/network_call_status.dart";
import "package:app/utils/utils.dart";
import "package:http/http.dart" as http;

class NetworkResponse<T> {
  /// Constructor to create a new response object
  NetworkResponse({
    this.callStatus = NetworkCallStatus.none,
    this.httpResponse,
    this.result,
  });

  /// Network call current status (i.e. loading or success etc)
  NetworkCallStatus callStatus;

  /// HTTP response object
  http.Response? httpResponse;

  /// Dart object that is created from the HTTP response
  T? result;

  /// Getter to get the HTTP response status code
  int get statusCode => httpResponse?.statusCode ?? -1;

  /// toString() method
  @override
  String toString() {
    return Utils.getModelString(
      runtimeType.toString(),
      <String, dynamic>{
        "callStatus": callStatus.name,
        "httpResponse": httpResponse.toString(),
        "result": "Instance of '${result.runtimeType.toString()}'",
      },
    );
  }
}
