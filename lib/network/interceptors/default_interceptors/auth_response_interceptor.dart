import "package:app/app_config/resources.dart";
import "package:app/network/enums/api_auth/auth_response_message_type.dart";
import "package:app/network/interceptors/interceptor_result.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/models/api_auth/auth_post_response.dart";
import "package:app/network/network_error.dart";
import "package:app/network/network_response.dart";
import "package:http/http.dart" as http;

/// Process authentication response
class AuthResponseInterceptor
    extends NetworkResponseInterceptor<AuthPostResponse> {
  @override
  RawResponseInterceptorResult interceptRawResponseBody(
    http.Response httpResponse,
  ) =>
      RawResponseInterceptorResult(httpResponse: httpResponse);

  @override
  ProcessedResponseInterceptorResult<AuthPostResponse>
      interceptProcessedResponse(
    NetworkResponse<AuthPostResponse> response,
  ) {
    AuthPostResponse? result = response.result;

    if (result != null) {
      AuthResponseMessageType messageType =
          AuthResponseMessageType.valueOf(result.msg ?? "");

      switch (messageType) {
        case AuthResponseMessageType.noAccount:
          response.error = NetworkError(
            title: Res.str.sorryTitle,
            message: Res.str.emailNotRegistered,
          );
          break;

        case AuthResponseMessageType.alreadyHasAccount:
          response.error = NetworkError(
            title: Res.str.sorryTitle,
            message: Res.str.accountAlreadyExists,
          );
          break;

        case AuthResponseMessageType.invalidPassword:
          response.error = NetworkError(
            title: Res.str.sorryTitle,
            message: Res.str.incorrectPassword,
          );
          break;

        case AuthResponseMessageType.tooSmallPassword:
          response.error = NetworkError(
            title: Res.str.sorryTitle,
            message: Res.str.passwordTooSmallLongMessage,
          );
          break;

        case AuthResponseMessageType.tooSmallName:
          response.error = NetworkError(
            title: Res.str.sorryTitle,
            message: Res.str.nameTooSmallLongMessage,
          );
          break;

        case AuthResponseMessageType.unknown:
          response.error = NetworkError.general();
          break;
      }
    }

    return ProcessedResponseInterceptorResult<AuthPostResponse>(
      response: response,
    );
  }
}
