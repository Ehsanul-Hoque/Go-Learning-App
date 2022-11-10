import "package:app/network/enums/network_call_status.dart";
import "package:app/network/network_call.dart";
import "package:app/network/network_client.dart";
import "package:app/network/network_logger.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";

/// DI => Dart object (input) (for serializer)
/// DO => Dart object (output) (for the final output)
class Network {
  static final Map<String, Object> _responseMap = <String, Object>{};

  static Future<NetworkResponse<DO>> createExecuteCall<DI, DO>({
    required NetworkClient client,
    required NetworkRequest<DI, DO> request,
    required OnUpdateListener updateListener,
  }) async {
    String apiFullUrl =
        (request.baseUrl ?? client.baseUrl) + request.apiEndPoint;
    String cacheKey = apiFullUrl;
    String logTag = "[HTTP ${request.callType.name}] [$apiFullUrl]";

    NetworkResponse<DO> response = getOrCreateResponse(cacheKey);

    if (response.callStatus == NetworkCallStatus.success) {
      NetLog()
          .d("$logTag Call requested, but has already completed successfully");
      NetLog().d("$logTag Response body:\n${response.httpResponse?.body}");
      NetLog().d("$logTag Result Model:\n${response.result?.toString()}");

      return response;
    }

    return NetworkCall<DI, DO>(
      client: client,
      request: request,
      response: response,
      updateListener: updateListener,
    ).execute();
  }

  static NetworkResponse<DO>? getResponse<DO>(String key) =>
      _responseMap[key] as NetworkResponse<DO>?;

  static NetworkResponse<DO> getOrCreateResponse<DO>(String key) =>
      getResponse(key) ?? _createResponse(key);

  static void clearAllResponses() {
    _responseMap.clear();
  }

  static NetworkResponse<DO> _createResponse<DO>(String key) {
    _responseMap[key] = NetworkResponse<DO>();
    return _responseMap[key]! as NetworkResponse<DO>;
  }
}
