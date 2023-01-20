import "dart:convert";

import "package:app/app_config/app_state.dart";
import "package:app/network/converters/json_converter.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/enums/network_call_type.dart";
import "package:app/network/interceptors/interceptor_result.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/network_callback.dart";
import "package:app/network/network_client.dart";
import "package:app/network/network_error.dart";
import "package:app/network/network_logger.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/network_utils.dart";
import "package:http/http.dart" as http;

/// DI => Dart object (input) (for serializer)
/// DO => Dart object (output) (for the final output)
class NetworkCall<DI, DO> {
  NetworkCall({
    required this.client,
    required this.request,
    required this.response,
    required this.responseConverter,
    this.requestInterceptors,
    this.responseInterceptors,
    this.callback,
  });

  /// The client
  final NetworkClient client;

  /// The request
  final NetworkRequest request;

  /// The response
  final NetworkResponse<DO> response;

  /// The converter for the response
  final JsonConverter<DI, DO> responseConverter;

  /// Network callback
  final NetworkCallback<DO>? callback;

  /// Request interceptors
  final List<NetworkRequestInterceptor>? requestInterceptors;

  /// Request interceptors
  final List<NetworkResponseInterceptor<DO>>? responseInterceptors;

  /// The session key for the network request (private)
  final String _sessionKey = AppState.currentSessionKey;

  // Some getters
  String get apiFullUrl =>
      (request.baseUrl ?? client.baseUrl) + request.apiEndPoint;
  String get logTag => "[HTTP ${request.callType.name}] [$apiFullUrl]";

  /// Method to start a network call
  Future<NetworkResponse<DO>> execute() async {
    return await _httpCall();
  }

  /// Method to make an HTTP call and process that response
  Future<NetworkResponse<DO>> _httpCall({
    bool logSteps = true,
    bool logResponse = true,
    bool logResultModel = true,
  }) async {
    NetLog().d("$logTag Call requested", showLog: logSteps);

    if (response.callStatus == NetworkCallStatus.loading) {
      NetLog().d(
        "$logTag Already another call ongoing, so no new call has started",
        showLog: logSteps,
      );
      callback?.onLoading?.call(response);
      callback?.onUpdate?.call(response);
      return response;
    }

    try {
      NetLog().d("$logTag Call started", showLog: logSteps);
      response.callStatus = NetworkCallStatus.loading;
      callback?.onLoading?.call(response);
      callback?.onUpdate?.call(response);

      if (!(await NetworkUtils.hasInternetConnection())) {
        NetLog().e("$logTag Call failed due to no internet", showLog: logSteps);
        response.callStatus = NetworkCallStatus.noInternet;
        callback?.onFailed?.call(response);
        callback?.onUpdate?.call(response);
        return response;
      }

      if (_isCallCancelled(logSteps: logSteps)) return response;

      http.Response? httpResponse =
          await _getHttpResponse(apiFullUrl, logSteps: logSteps);

      if (_isCallCancelled(logSteps: logSteps)) return response;

      httpResponse =
          _runRawResponseInterceptors(responseInterceptors, httpResponse);

      if (httpResponse == null) {
        response.callStatus = NetworkCallStatus.failed;
        callback?.onFailed?.call(response);
        callback?.onUpdate?.call(response);
        return response;
      }

      response.httpResponse = httpResponse;
      _processHttpResponse();
      // Utils.log("response [3]: $response");
      _runProcessedResponseInterceptors(responseInterceptors, response);
      // Utils.log("response [4]: $response");

      if (response.callStatus == NetworkCallStatus.success) {
        callback?.onSuccess?.call(response);
        callback?.onUpdate?.call(response);
        NetLog().d("$logTag Call succeeded", showLog: logSteps);
      } else {
        callback?.onFailed?.call(response);
        callback?.onUpdate?.call(response);
        NetLog().e(
          "$logTag Call failed."
          " HTTP ${httpResponse.statusCode}: ${httpResponse.reasonPhrase}",
          showLog: logSteps,
        );
      }
    } catch (e, s) {
      response.callStatus = NetworkCallStatus.failed;
      callback?.onFailed?.call(response);
      callback?.onUpdate?.call(response);

      NetLog()
          .e("$logTag Call failed", error: e, stackTrace: s, showLog: logSteps);
    }

    NetLog().d(
      "$logTag Response body:\n${response.httpResponse?.body}",
      showLog: logResponse,
    );
    NetLog().d(
      "$logTag Result Model:\n${response.result?.toString()}",
      showLog: logResultModel,
    );

    return response;
  }

  /// Private method to get an HTTP response
  Future<http.Response?> _getHttpResponse(
    String apiFullUrl, {
    bool logSteps = true,
  }) async {
    switch (request.callType) {
      case NetworkCallType.get:
        return http.get(
          Uri.parse(apiFullUrl),
          headers: request.headers ?? client.headers,
        );

      case NetworkCallType.post:
        NetLog().d(
          "$logTag post body = ${request.body}",
          showLog: logSteps,
        );
        return http.post(
          Uri.parse(apiFullUrl),
          headers: request.headers ?? client.headers,
          body: jsonEncode(request.body),
        );

      case NetworkCallType.put:
        NetLog().d(
          "$logTag put body = ${request.body}",
          showLog: logSteps,
        );
        return http.put(
          Uri.parse(apiFullUrl),
          headers: request.headers ?? client.headers,
          body: jsonEncode(request.body),
        );
    }
  }

  /// Private method to process a HTTP response
  void _processHttpResponse() {
    http.Response? httpResponse = response.httpResponse;
    if (httpResponse == null) {
      response.callStatus = NetworkCallStatus.failed;
      return;
    }

    if (httpResponse.statusCode >= 200 && httpResponse.statusCode < 300) {
      response.callStatus = NetworkCallStatus.success;
    } else {
      response
        ..callStatus = NetworkCallStatus.failed
        ..error = NetworkError(
          title: "${httpResponse.statusCode}!",
          message: httpResponse.reasonPhrase ?? "",
        );
    }

    response
      ..httpResponse = httpResponse
      ..result = responseConverter.fromJsonToDart(httpResponse.body);
  }

  /// Private method to mark the network call as cancelled
  bool _isCallCancelled({required bool logSteps}) {
    if (!AppState.isValidSessionKey(_sessionKey)) {
      NetLog().e(
        "$logTag Call cancelled (Session key has been changed).",
        showLog: logSteps,
      );
      response.callStatus = NetworkCallStatus.cancelled;
      callback?.onCancelled?.call(response);
      callback?.onUpdate?.call(response);
      return true;
    }

    return false;
  }

  /// Private method to run the raw response interceptors
  static http.Response? _runRawResponseInterceptors<DO>(
    List<NetworkResponseInterceptor<DO>>? responseInterceptors,
    http.Response? httpResponse,
  ) {
    if (responseInterceptors != null) {
      http.Response? interceptedResponse = httpResponse;

      for (NetworkResponseInterceptor<DO> interceptor in responseInterceptors) {
        if (interceptedResponse != null) {
          RawResponseInterceptorResult interceptorResult =
              interceptor.interceptRawResponseBody(interceptedResponse);

          interceptedResponse = interceptorResult.httpResponse;
        } else {
          break;
        }
      }

      httpResponse = interceptedResponse;
    }

    return httpResponse;
  }

  /// Private method to run the processed response interceptors
  static void _runProcessedResponseInterceptors<DO>(
    List<NetworkResponseInterceptor<DO>>? responseInterceptors,
    NetworkResponse<DO> response,
  ) {
    if (responseInterceptors != null) {
      NetworkResponse<DO> interceptedResponse = response;

      for (NetworkResponseInterceptor<DO> interceptor in responseInterceptors) {
        ProcessedResponseInterceptorResult<DO> interceptorResult =
            interceptor.interceptProcessedResponse(interceptedResponse);

        interceptedResponse = interceptorResult.response;
      }

      response.copyFrom(interceptedResponse);
    }
  }
}
