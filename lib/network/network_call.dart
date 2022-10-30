import "package:app/network/enums/network_call_status.dart";
import "package:app/network/enums/network_call_type.dart";
import "package:app/network/network_client.dart";
import "package:app/network/network_logger.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/network_utils.dart";
import "package:app/utils/typedefs.dart" show OnErrorListener;
import "package:http/http.dart" as http;

typedef OnUpdateListener = void Function();

/*void Function<DI, DO>(
  NetworkClient client,
  NetworkRequest<DI, DO> request,
  NetworkResponse<DO> response,
);*/

/// DI => Dart object (input) (for serializer)
/// DO => Dart object (output) (for the final output)
class NetworkCall<DI, DO> {
  // NetworkCallType callType;
  final NetworkClient _client;
  NetworkClient get client => _client;

  final NetworkRequest<DI, DO> _request;
  NetworkRequest<DI, DO> get request => _request;

  final NetworkResponse<DO> _response;
  NetworkResponse<DO> get response => _response;

  final OnUpdateListener _updateListener;
  OnUpdateListener get updateListener => _updateListener;

  NetworkCall({
    required NetworkClient client,
    required NetworkRequest<DI, DO> request,
    required NetworkResponse<DO> response,
    required OnUpdateListener updateListener,
  })  : _client = client,
        _request = request,
        _response = response,
        _updateListener = updateListener;

  Future<NetworkResponse<DO>> execute() async {
    return await _httpCall();
  }

  /// Method to make an HTTP call and process that response
  Future<NetworkResponse<DO>> _httpCall({
    bool cacheTemporarily = true,
    bool logSteps = true,
    bool logResponse = true,
    bool logResultModel = true,
  }) async {
    String apiFullUrl =
        (request.baseUrl ?? client.baseUrl) + request.apiEndPoint;
    String tag = "[HTTP ${request.callType.name}] [$apiFullUrl]";

    NetLog().d("$tag Call requested", showLog: logSteps);

    if (_isLoadingOrHasAlreadyCompletedRequest(
      tag,
      cacheTemporarily: cacheTemporarily,
      logSteps: logSteps,
      logResponse: logResponse,
      logResultModel: logResultModel,
    )) {
      updateListener();
      return response;
    }

    try {
      NetLog().d("$tag Call started", showLog: logSteps);
      response.callStatus = NetworkCallStatus.loading;
      updateListener();

      if (!(await NetworkUtils.hasInternetConnection())) {
        NetLog().e("$tag Call failed due to no internet", showLog: logSteps);
        response.callStatus = NetworkCallStatus.noInternet;
        updateListener();
        return response;
      }

      http.Response? httpResponse = await _getHttpResponse(
        apiFullUrl,
        (NetworkCallType callType) {
          NetLog().e(
            "$tag Call failed. Call of type ${callType.name}"
            " is not supported yet",
            showLog: logSteps,
          );
        },
      );

      if (httpResponse == null) {
        response.callStatus = NetworkCallStatus.failed;
        updateListener();
        return response;
      }

      response.httpResponse = httpResponse;
      _processHttpResponse();

      if (response.callStatus == NetworkCallStatus.success) {
        NetLog().d("$tag Call succeeded", showLog: logSteps);
      } else {
        NetLog().e(
          "$tag Call failed."
          " HTTP ${httpResponse.statusCode}: ${httpResponse.reasonPhrase}",
          showLog: logSteps,
        );
      }
    } catch (e, s) {
      response.callStatus = NetworkCallStatus.failed;
      NetLog()
          .e("$tag Call failed", error: e, stackTrace: s, showLog: logSteps);
    }

    NetLog().d(
      "$tag Response body:\n${response.httpResponse?.body}",
      showLog: logResponse,
    );
    NetLog().d(
      "$tag Result Model:\n${response.result?.toString()}",
      showLog: logResultModel,
    );

    updateListener();
    return response;
  }

  /// Private method to check if a request is loading or has already completed
  bool _isLoadingOrHasAlreadyCompletedRequest(
    String tag, {
    bool cacheTemporarily = true,
    bool logSteps = true,
    bool logResponse = false,
    bool logResultModel = false,
  }) {
    if (response.callStatus == NetworkCallStatus.loading) {
      NetLog().d(
        "$tag Already another call ongoing, so no new call has started",
        showLog: logSteps,
      );
      return true;
    } else if (cacheTemporarily &&
        (response.callStatus == NetworkCallStatus.success)) {
      NetLog().d("$tag Call already completed successfully", showLog: logSteps);
      NetLog().d(
        "$tag Response body:\n${response.httpResponse?.body}",
        showLog: logResponse,
      );
      NetLog().d(
        "$tag Result Model:\n${response.result?.toString()}",
        showLog: logResultModel,
      );
      return true;
    }

    return false;
  }

  /// Private method to get an HTTP response
  Future<http.Response?> _getHttpResponse(
    String apiFullUrl,
    OnErrorListener<NetworkCallType> onError,
  ) async {
    switch (request.callType) {
      case NetworkCallType.get:
        return http.get(
          Uri.parse(apiFullUrl),
          headers: request.headers ?? client.headers,
        );

      case NetworkCallType.post:
        onError(NetworkCallType.post);
        return null;
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
        ..result = request.converter
            .fromJsonToDart(httpResponse.body, request.serializer);
    } else {
      response.callStatus = NetworkCallStatus.failed;
    }
  }
}
