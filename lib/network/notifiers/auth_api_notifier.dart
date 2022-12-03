import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/models/api_auth/sign_in_post_request.dart";
import "package:app/network/models/api_auth/sign_in_post_response.dart";
import "package:app/network/network.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class AuthApiNotifier extends ApiNotifier {
  /// API endpoints
  static const String signInPostApiEndpoint = "/student/signin";
  static const String profileGetApiEndpoint = "/student/profile";

  /// Constructor
  AuthApiNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<AuthApiNotifier>(
        create: (BuildContext context) => AuthApiNotifier(),
      );

  /// Methods to sign in with email and password
  Future<NetworkResponse<SignInPostResponse>> signInWithEmailPassword(
    SignInPostRequest requestBody,
  ) {
    return const Network().createExecuteCall(
      client: defaultClient,
      request: NetworkRequest.post(
        apiEndPoint: signInPostApiEndpoint,
        body: requestBody.toJson(),
      ),
      responseConverter: const JsonObjectConverter<SignInPostResponse>(
        SignInPostResponse.fromJson,
      ),
      updateListener: () => notifyListeners(),
      loadFromCacheIfPossible: false,
    );
  }

  NetworkResponse<SignInPostResponse> signInWithEmailPasswordResponse() =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + signInPostApiEndpoint,
      );

  /// Methods to get user profile
  Future<NetworkResponse<ProfileGetResponse>> getProfile() {
    return const Network().createExecuteCall(
      client: defaultClient,
      request: const NetworkRequest.get(
        apiEndPoint: profileGetApiEndpoint,
      ),
      responseConverter: const JsonObjectConverter<ProfileGetResponse>(
        ProfileGetResponse.fromJson,
      ),
      updateListener: () => notifyListeners(),
      loadFromCacheIfPossible: false,
    );
  }

  NetworkResponse<ProfileGetResponse> profileGetResponse() =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + profileGetApiEndpoint,
      );
}
