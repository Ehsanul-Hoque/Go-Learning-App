import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/local_storage/notifiers/user_notifier.dart";
import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/interceptors/default_interceptors/access_token_interceptor.dart";
import "package:app/network/interceptors/default_interceptors/guest_interceptor.dart";
import "package:app/network/interceptors/network_interceptor.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/models/api_auth/sign_in_post_request.dart";
import "package:app/network/models/api_auth/auth_post_response.dart";
import "package:app/network/models/api_auth/sign_up_post_request.dart";
import "package:app/network/models/api_auth/tokenize_sign_in_post_request.dart";
import "package:app/network/network.dart";
import "package:app/network/network_callback.dart";
import "package:app/network/network_request.dart";
import "package:app/network/network_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:google_sign_in/google_sign_in.dart";
import "package:provider/provider.dart"
    show ChangeNotifierProvider, ReadContext;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId:
      "901568231687-t771hpsgnltpk5f86edui2cakmuk6rpr.apps.googleusercontent.com",
  scopes: <String>[
    "email",
    "profile",
  ],
);

class AuthApiNotifier extends ApiNotifier {
  /// API endpoints
  static const String signUpPostApiEndpoint = "/student/signup";
  static const String signInPostApiEndpoint = "/student/signin";
  static const String signInTokenizePostApiEndpoint =
      "/student/tokenize_signin";
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
    BuildContext context,
    SignUpPostRequest requestBody,
  ) {
    context.read<UserNotifier?>()?.logOut();

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
      callback: NetworkCallback<AuthPostResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<AuthPostResponse> get signUpWithEmailPasswordResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + signUpPostApiEndpoint,
      );

  /*void _resetSignUpWithEmailPasswordResponse() {
    Network.resetResponse(defaultClient.baseUrl + signUpPostApiEndpoint);
  }*/

  /// Methods to sign in with email and password
  Future<NetworkResponse<AuthPostResponse>> signInWithEmailPassword(
    BuildContext context,
    SignInPostRequest requestBody,
  ) {
    context.read<UserNotifier?>()?.logOut();

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
      callback: NetworkCallback<AuthPostResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<AuthPostResponse> get signInWithEmailPasswordResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + signInPostApiEndpoint,
      );

  /*void _resetSignInWithEmailPasswordResponse() {
    Network.resetResponse(defaultClient.baseUrl + signInPostApiEndpoint);
  }*/

  /// Methods to sign in with email and password
  Future<NetworkResponse<AuthPostResponse>> signInWithGoogle(
    BuildContext context,
  ) async {
    context.read<UserNotifier?>()?.logOut();

    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;
      String? idToken = googleAuth?.idToken;

      if (idToken == null) {
        // ignore: use_build_context_synchronously
        context.showSnackBar(
          AppSnackBarContent(
            title: Res.str.sorryTitle,
            message: Res.str.errorLogIn,
            contentType: ContentType.help,
          ),
        );

        return signInWithGoogleResponse;
      }

      return const Network().createExecuteCall(
        client: defaultClient,
        requestInterceptors: <NetworkRequestInterceptor>[GuestInterceptor()],
        request: NetworkRequest.post(
          apiEndPoint: signInTokenizePostApiEndpoint,
          body: TokenizeSignInPostRequest(onetimeToken: idToken).toJson(),
        ),
        responseConverter: const JsonObjectConverter<AuthPostResponse>(
          AuthPostResponse.fromJson,
        ),
        callback: NetworkCallback<AuthPostResponse>(
          onUpdate: (_) => notifyListeners(),
        ),
        checkCacheFirst: false,
      );
    } catch (e, s) {
      Utils.log("", error: e, stackTrace: s);

      try {
        context.showSnackBar(
          AppSnackBarContent(
            title: Res.str.sorryTitle,
            message: Res.str.errorLogIn,
            contentType: ContentType.help,
          ),
        );
      } catch (e, s) {
        Utils.log("", error: e, stackTrace: s);
      }
    }

    return signInWithGoogleResponse;
  }

  NetworkResponse<AuthPostResponse> get signInWithGoogleResponse =>
      Network.getOrCreateResponse(
        defaultClient.baseUrl + signInTokenizePostApiEndpoint,
      );

  /*void _resetSignInWithGoogleResponse() {
    Network.resetResponse(
      defaultClient.baseUrl + signInTokenizePostApiEndpoint,
    );
  }*/

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
      callback: NetworkCallback<ProfileGetResponse>(
        onUpdate: (_) => notifyListeners(),
      ),
      checkCacheFirst: false,
    );
  }

  NetworkResponse<ProfileGetResponse> get profileGetResponse =>
      Network.getOrCreateResponse(
        defaultAuthenticatedClient.baseUrl + profileGetApiEndpoint,
      );

  /*/// Method to clear previous auth responses if not loading.
  /// Call this method before starting every new
  /// auth request (sign in or sign up).
  void resetAuthResponses() {
    if (signUpWithEmailPasswordResponse.callStatus !=
        NetworkCallStatus.loading) {
      _resetSignUpWithEmailPasswordResponse();
    }

    if (signInWithEmailPasswordResponse.callStatus !=
        NetworkCallStatus.loading) {
      _resetSignInWithEmailPasswordResponse();
    }

    if (signInWithGoogleResponse.callStatus != NetworkCallStatus.loading) {
      _resetSignInWithGoogleResponse();
    }

    notifyListeners();
  }*/
}
