import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/interceptors/default_interceptors/access_token_interceptor.dart";
import "package:app/network/interceptors/default_interceptors/guest_interceptor.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/models/api_auth/sign_in_post_request.dart";
import "package:app/network/models/api_auth/auth_post_response.dart";
import "package:app/network/models/api_auth/sign_up_post_request.dart";
import "package:app/network/network.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class AuthApiNotifier extends ApiNotifier {
  /// API endpoints
  static const String signUpPostApiEndpoint = "/student/signup";
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
  Future<NetworkResponse<AuthPostResponse>> signUpWithEmailPassword(
    SignUpPostRequest requestBody,
  ) {
    return const Network().createExecuteCall(
      client: defaultClient,
      requestInterceptors: <NetworkRequestInterceptor>[GuestInterceptor()],
      request: NetworkRequest.post(
        apiEndPoint: signUpPostApiEndpoint,
        body: requestBody.toJson(),
      ),
      responseConverter: const JsonObjectConverter<AuthPostResponse>(
        AuthPostResponse.fromJson,
      ),
      updateListener: () => notifyListeners(),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<AuthPostResponse> get signUpWithEmailPasswordResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + signUpPostApiEndpoint,
      );

  void deleteSignUpWithEmailPasswordResponse() {
    Network.deleteResponse(defaultClient.baseUrl + signUpPostApiEndpoint);
  }

  /// Methods to sign in with email and password
  Future<NetworkResponse<AuthPostResponse>> signInWithEmailPassword(
    SignInPostRequest requestBody,
  ) {
    return const Network().createExecuteCall(
      client: defaultClient,
      requestInterceptors: <NetworkRequestInterceptor>[GuestInterceptor()],
      request: NetworkRequest.post(
        apiEndPoint: signInPostApiEndpoint,
        body: requestBody.toJson(),
      ),
      responseConverter: const JsonObjectConverter<AuthPostResponse>(
        AuthPostResponse.fromJson,
      ),
      updateListener: () => notifyListeners(),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<AuthPostResponse> get signInWithEmailPasswordResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + signInPostApiEndpoint,
      );

  void deleteSignInWithEmailPasswordResponse() {
    Network.deleteResponse(defaultClient.baseUrl + signInPostApiEndpoint);
  }

  /// Methods to get user profile
  Future<NetworkResponse<ProfileGetResponse>> getProfile() {
    return const Network().createExecuteCall(
      client: defaultAuthenticatedClient,
      requestInterceptors: <NetworkRequestInterceptor>[
        AccessTokenInterceptor(),
      ],
      request: const NetworkRequest.get(
        apiEndPoint: profileGetApiEndpoint,
      ),
      responseConverter: const JsonObjectConverter<ProfileGetResponse>(
        ProfileGetResponse.fromJson,
      ),
      updateListener: () => notifyListeners(),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<ProfileGetResponse> get profileGetResponse =>
      Network.getOrCreateResponse(
        defaultAuthenticatedClient.baseUrl + profileGetApiEndpoint,
      );

  /// Method to clear previous auth responses if not loading.
  /// Call this method before starting every new
  /// auth request (sign in or sign up).
  void deleteAuthResponses() {
    if (signUpWithEmailPasswordResponse.callStatus !=
        NetworkCallStatus.loading) {
      deleteSignUpWithEmailPasswordResponse();
    }

    if (signInWithEmailPasswordResponse.callStatus !=
        NetworkCallStatus.loading) {
      deleteSignInWithEmailPasswordResponse();
    }
  }
}
