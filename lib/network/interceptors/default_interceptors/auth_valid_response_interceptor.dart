import "dart:convert" show jsonDecode;

import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/enums/api_auth/auth_response_message_type.dart";
import "package:app/network/interceptors/interceptor_result.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/models/api_model.dart";
import "package:app/network/network_logger.dart";
import "package:app/network/network_response.dart";
import "package:app/routes.dart";
import "package:http/http.dart" as http;

/// Interceptor to process if current auth is valid
class AuthValidResponseInterceptor<T extends ApiModel>
    extends NetworkResponseInterceptor<T> {
  @override
  RawResponseInterceptorResult interceptRawResponseBody(
    http.Response httpResponse,
  ) {
    try {
      String body = httpResponse.body;
      dynamic rawResponse = jsonDecode(body);
      String? msg = (rawResponse as Map<String, dynamic>?)?["msg"] as String?;

      if (msg == null) {
        return RawResponseInterceptorResult(httpResponse: httpResponse);
      }

      AuthResponseMessageType messageType =
          AuthResponseMessageType.valueOf(msg);

      if (messageType == AuthResponseMessageType.jwtExpired) {
        NetLog().e(
          "Current user token (JWT) has been expired."
          " You will be logged out now.",
        );
        UserBox.logOut();
        Routes().openSplashPage();
        return RawResponseInterceptorResult(httpResponse: null);
      }
    } catch (e, s) {
      NetLog().e("", error: e, stackTrace: s);
    }

    return RawResponseInterceptorResult(httpResponse: httpResponse);
  }

  @override
  ProcessedResponseInterceptorResult<T> interceptProcessedResponse(
    NetworkResponse<T> response,
  ) =>
      ProcessedResponseInterceptorResult<T>(
        response: response,
      );
}
