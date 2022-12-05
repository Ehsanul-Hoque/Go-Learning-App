import "package:app/network/interceptors/interceptor_result.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:http/http.dart" as http;

abstract class NetworkRequestInterceptor {
  /// Allow,block or process request.
  /// Set the request value in the result model to null
  /// if the request should be blocked, non-null otherwise.
  RequestInterceptorResult intercept(NetworkRequest request);
}

abstract class NetworkResponseInterceptor<DO> {
  /// Process raw response
  RawResponseInterceptorResult interceptRawResponseBody(
    http.Response? httpResponse,
  );

  /// Process response body after it has been converted to dart model
  ProcessedResponseInterceptorResult<DO> interceptProcessedResponse(
    NetworkResponse<DO> response,
  );
}
