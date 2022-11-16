import "package:app/network/enums/network_call_status.dart";
import "package:app/utils/utils.dart";
import "package:http/http.dart" as http;

class NetworkResponse<T> {
  NetworkCallStatus callStatus;
  http.Response? httpResponse;
  T? result;

  NetworkResponse({
    this.callStatus = NetworkCallStatus.none,
    this.httpResponse,
    this.result,
  });

  int get statusCode => httpResponse?.statusCode ?? -1;

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
