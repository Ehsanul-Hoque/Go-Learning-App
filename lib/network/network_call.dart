import "dart:convert";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/enums/network_call_type.dart";
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

      http.Response? httpResponse = await _getHttpResponse(apiFullUrl);

      if (httpResponse == null) {
        response.callStatus = NetworkCallStatus.failed;
        callback?.onFailed?.call(response);
        callback?.onUpdate?.call(response);
        return response;
      }

      response.httpResponse = httpResponse;
      _processHttpResponse();

      if (response.callStatus == NetworkCallStatus.success) {
        callback?.onSuccess?.call(response);
        NetLog().d("$logTag Call succeeded", showLog: logSteps);
      } else {
        callback?.onFailed?.call(response);
        NetLog().e(
          "$logTag Call failed."
          " HTTP ${httpResponse.statusCode}: ${httpResponse.reasonPhrase}",
          showLog: logSteps,
        );
      }
    } catch (e, s) {
      response.callStatus = NetworkCallStatus.failed;
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

    callback?.onUpdate?.call(response);
    return response;
  }

  /// Private method to get an HTTP response
  Future<http.Response?> _getHttpResponse(String apiFullUrl) async {
    switch (request.callType) {
      case NetworkCallType.get:
        return http.get(
          Uri.parse(apiFullUrl),
          headers: request.headers ?? client.headers,
        );

      case NetworkCallType.post:
        return http.post(
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
      response
        ..callStatus = NetworkCallStatus.success
        ..httpResponse = httpResponse
        ..result = responseConverter.fromJsonToDart(httpResponse.body);
    } else {
      response
        ..callStatus = NetworkCallStatus.failed
        ..error = NetworkError(
          title: "${httpResponse.statusCode}!",
          message: httpResponse.reasonPhrase ?? "",
        );
    }
  }
}
