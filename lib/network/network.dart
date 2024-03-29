import "dart:ui";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/interceptors/interceptor_result.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/network_call.dart";
import "package:app/network/network_callback.dart";
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
    List<NetworkRequestInterceptor>? requestInterceptors,
    List<NetworkResponseInterceptor<DO>>? responseInterceptors,
    NetworkCallback<DO>? callback,
    bool checkCacheFirst = true,
  }) async {
    // Initialize some fields
    String apiFullUrl =
        (request.baseUrl ?? client.baseUrl) + request.apiEndPoint;
    String cacheKey = apiFullUrl;
    String logTag = "[HTTP ${request.callType.name}] [$apiFullUrl]";

    // Get cached/new response object
    NetworkResponse<DO> response =
        getOrCreateResponse(cacheKey, storeInCache: true);
    resetResponseIfUnsuccessful(response);
    callback?.onStart?.call(response);
    callback?.onUpdate?.call(response);

    // Process the request interceptors
    response = _processInterceptors(request, requestInterceptors, response);
    if (response.callStatus == NetworkCallStatus.failed) {
      callback?.onFailed?.call(response);
      callback?.onUpdate?.call(response);

      NetLog().e(
        "$logTag Call failed."
        " Request could not pass all request interceptors."
        " Response error = ${response.error}",
      );

      return response;
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
      callback?.onLoading?.call(response);
      callback?.onUpdate?.call(response);

      await Future<void>.delayed(const Duration(milliseconds: 200));

      response.callStatus = NetworkCallStatus.success;
      callback?.onSuccess?.call(response);
      callback?.onUpdate?.call(response);
      return response;
    }

    // Create and start a new network call
    return NetworkCall<DI, DO>(
      client: client,
      request: request,
      response: response,
      responseConverter: responseConverter,
      requestInterceptors: requestInterceptors,
      responseInterceptors: responseInterceptors,
      callback: callback,
    ).execute();
  }

  /// Method to get a response object from the temporary cache
  static NetworkResponse<DO>? getResponse<DO>(String key) =>
      _responseMap[key] as NetworkResponse<DO>?;

  /// Method to get a response object from the temporary cache,
  /// or create if it does not exist
  static NetworkResponse<DO> getOrCreateResponse<DO>(
    String key, {
    bool storeInCache = false,
  }) =>
      getResponse(key) ?? _createResponse(key, storeInCache);

  /// Method to reset a response object in the temporary cache
  static void resetResponse(String key, [VoidCallback? updateListener]) {
    getResponse(key)?.reset();
    updateListener?.call();
  }

  /// Method to reset a response object in the temporary cache
  /// if the request has been completed unsuccessfully
  static void resetResponseIfUnsuccessful<DO>(
    NetworkResponse<DO>? response, [
    VoidCallback? updateListener,
  ]) {
    if (response == null) return;

    switch (response.callStatus) {
      case NetworkCallStatus.noInternet:
      case NetworkCallStatus.cancelled:
      case NetworkCallStatus.failed:
        response.reset();
        updateListener?.call();
        break;

      case NetworkCallStatus.none:
      case NetworkCallStatus.loading:
      case NetworkCallStatus.success:
        break;
    }
  }

  /// Method to reset the temporary cache
  static void resetAllResponses([VoidCallback? updateListener]) {
    for (String key in _responseMap.keys) {
      resetResponse(key);
    }

    updateListener?.call();
  }

  /// Private method to create a response object in the temporary cache
  static NetworkResponse<DO> _createResponse<DO>(
    String key,
    bool storeInCache,
  ) {
    NetworkResponse<DO> networkResponse = NetworkResponse<DO>();
    if (!storeInCache) return networkResponse;

    _responseMap[key] = networkResponse;
    return _responseMap[key]! as NetworkResponse<DO>;
  }

  /// Private method to process the request interceptors
  static NetworkResponse<DO> _processInterceptors<DO>(
    NetworkRequest request,
    List<NetworkRequestInterceptor>? requestInterceptors,
    NetworkResponse<DO> response,
  ) {
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

    return response;
  }
}
