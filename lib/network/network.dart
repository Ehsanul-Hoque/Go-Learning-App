import "dart:ui";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/interceptors/interceptor_result.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/network_call.dart";
import "package:app/network/network_client.dart";
import "package:app/network/network_error.dart";
import "package:app/network/network_logger.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";

/// DI => Dart object (input) (for serializer)
/// DO => Dart object (output) (for the final output)
class Network {
  /// Map to represent the temporary cache
  static final Map<String, Object> _responseMap = <String, Object>{};

  /// Default constructor
  const Network();

  /// Method to create and execute a network call
  Future<NetworkResponse<DO>> createExecuteCall<DI, DO>({
    required NetworkClient client,
    required NetworkRequest request,
    required JsonConverter<DI, DO> responseConverter,
    required OnUpdateListener updateListener,
    OnSuccessListener<DO>? successListener,
    List<NetworkRequestInterceptor>? requestInterceptors,
    bool checkCacheFirst = true,
  }) async {
    // Initialize some fields
    String apiFullUrl =
        (request.baseUrl ?? client.baseUrl) + request.apiEndPoint;
    String cacheKey = apiFullUrl;
    String logTag = "[HTTP ${request.callType.name}] [$apiFullUrl]";

    // Get cached/new response object
    NetworkResponse<DO> response = getOrCreateResponse(cacheKey);

    // Run the request interceptors
    if (requestInterceptors != null) {
      NetworkRequest? interceptedRequest = request;
      NetworkError? error;

      for (NetworkRequestInterceptor interceptor in requestInterceptors) {
        if (interceptedRequest != null) {
          RequestInterceptorResult interceptorResult =
              interceptor.intercept(interceptedRequest);

          interceptedRequest = interceptorResult.request;
          error = interceptorResult.error;
        } else {
          break;
        }
      }

      if (interceptedRequest == null || error != null) {
        return response
          ..callStatus = NetworkCallStatus.failed
          ..error = error;
      }

      request = interceptedRequest;
    }

    // If the call has been completed already, then no need to start a new call.
    // But set the response to loading state, delay a bit to notify
    // the listeners properly, and then set the response to success again.
    // Because if there is any selector that already has returned
    // the previous success response, the new success response from the cache
    // won't trigger that selector again. So to trigger that,
    // we have to set the response to loading first.
    if (checkCacheFirst && (response.callStatus == NetworkCallStatus.success)) {
      NetLog()
          .d("$logTag Call requested, but has already completed successfully");
      NetLog().d("$logTag Response body:\n${response.httpResponse?.body}");
      NetLog().d("$logTag Result Model:\n${response.result?.toString()}");

      response.callStatus = NetworkCallStatus.loading;
      updateListener();

      await Future<void>.delayed(const Duration(milliseconds: 200));

      response.callStatus = NetworkCallStatus.success;
      updateListener();
      return response;
    }

    // Create and start a new network call
    return NetworkCall<DI, DO>(
      client: client,
      request: request,
      response: response,
      responseConverter: responseConverter,
      updateListener: updateListener,
      successListener: successListener,
    ).execute();
  }

  /// Method to get a response object from the temporary cache
  static NetworkResponse<DO>? getResponse<DO>(String key) =>
      _responseMap[key] as NetworkResponse<DO>?;

  /// Method to get a response object from the temporary cache,
  /// or create if it does not exist
  static NetworkResponse<DO> getOrCreateResponse<DO>(String key) =>
      getResponse(key) ?? _createResponse(key);

  /// Method to reset a response object in the temporary cache
  static void resetResponse<DO>(String key, [VoidCallback? updateListener]) {
    getResponse(key)?.reset();
    updateListener?.call();
  }

  /// Method to reset the temporary cache
  static void resetAllResponses([VoidCallback? updateListener]) {
    for (String key in _responseMap.keys) {
      resetResponse(key);
    }

    updateListener?.call();
  }

  /// Private method to create a response object in the temporary cache
  static NetworkResponse<DO> _createResponse<DO>(String key) {
    _responseMap[key] = NetworkResponse<DO>();
    return _responseMap[key]! as NetworkResponse<DO>;
  }
}
