import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_auth/sign_in_post_request_model.dart";
import "package:app/network/models/api_auth/sign_in_post_response_model.dart";
import "package:app/network/models/api_coupons/coupon_response_model.dart";
import "package:app/network/models/base_api_response_model.dart";
import "package:app/network/network.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/network/serializers/api_auth/sign_in_post_request_serializer.dart";
import "package:app/network/serializers/api_auth/sign_in_post_response_serializer.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class AuthApiNotifier extends ApiNotifier {
  /// API endpoints
  static String signInPostApiEndpoint() {
    return "/student/signin";
  }

  /// Constructor
  AuthApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<AuthApiNotifier>(
        create: (BuildContext context) => AuthApiNotifier(),
      );

  /// Methods to sign in with email and password
  Future<NetworkResponse<SignInPostResponseModel>> signInWithEmailPassword(
    SignInPostRequestModel requestBody,
  ) {
    return const Network().createExecuteCall(
      client: defaultClient,
      request: NetworkRequest.post(
        apiEndPoint: signInPostApiEndpoint(),
        body: const SignInPostRequestSerializer().toJson(requestBody),
      ),
      responseConverter: const JsonObjectConverter<SignInPostResponseModel>(
        SignInPostResponseSerializer(),
      ),
      updateListener: () => notifyListeners(),
      loadFromCacheIfPossible: false,
    );
  }

  NetworkResponse<BaseApiResponseModel<CouponResponseModel>>
      signInWithEmailPasswordResponse() {
    return Network.getOrCreateResponse(
      defaultClient.baseUrl + signInPostApiEndpoint(),
    );
  }
}
