import "package:app/app_config/resources.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/interceptors/interceptor_result.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/network_error.dart";
import "package:app/network/network_request.dart";

/// Allow request only if the app has any access token saved
class AccessTokenInterceptor extends NetworkRequestInterceptor {
  @override
  RequestInterceptorResult intercept(NetworkRequest request) {
    if (UserBox.hasAccessToken) {
      return RequestInterceptorResult(request: request);
    }

    return RequestInterceptorResult(
      error: NetworkError(
        title: Res.str.unauthenticatedTitle,
        message: Res.str.unauthenticatedMessage,
      ),
    );
  }
}
