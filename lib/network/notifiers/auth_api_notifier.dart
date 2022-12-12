import "package:app/app_config/resources.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/local_storage/boxes/userbox.dart";
import "package:app/local_storage/notifiers/user_notifier.dart";
import "package:app/network/converters/default_converters/json_object_converter.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/interceptors/default_interceptors/auth_interceptor.dart";
import "package:app/network/interceptors/default_interceptors/auth_response_interceptor.dart";
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
import "package:dart_jsonwebtoken/dart_jsonwebtoken.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:provider/provider.dart"
    show ChangeNotifierProvider, ReadContext;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

GoogleSignIn googleSignIn = GoogleSignIn(
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

  /// Common response object
  NetworkResponse<Object> get authResponse =>
      Network.getOrCreateResponse("auth_response");

  /// Methods to sign in with email and password
  Future<NetworkResponse<AuthPostResponse>> signUpWithEmailPassword(
    BuildContext context,
    SignUpPostRequest requestBody,
  ) async {
    await context.read<UserNotifier?>()?.logOut();

    return const Network().createExecuteCall(
      client: defaultClient,
      requestInterceptors: <NetworkRequestInterceptor>[GuestInterceptor()],
      request: NetworkRequest.post(
        apiEndPoint: signUpPostApiEndpoint,
        body: requestBody.toJson(),
      ),
      responseInterceptors: <NetworkResponseInterceptor<AuthPostResponse>>[
        AuthResponseInterceptor(),
      ],
      responseConverter: const JsonObjectConverter<AuthPostResponse>(
        AuthPostResponse.fromJson,
      ),
      callback: NetworkCallback<AuthPostResponse>(
        onLoading: (_) => authResponse.callStatus = NetworkCallStatus.loading,
        onSuccess: onAccessTokenGetSuccess,
        onFailed: onAccessTokenGetFailed,
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
  ) async {
    await context.read<UserNotifier?>()?.logOut();

    return const Network().createExecuteCall(
      client: defaultClient,
      requestInterceptors: <NetworkRequestInterceptor>[GuestInterceptor()],
      request: NetworkRequest.post(
        apiEndPoint: signInPostApiEndpoint,
        body: requestBody.toJson(),
      ),
      responseInterceptors: <NetworkResponseInterceptor<AuthPostResponse>>[
        AuthResponseInterceptor(),
      ],
      responseConverter: const JsonObjectConverter<AuthPostResponse>(
        AuthPostResponse.fromJson,
      ),
      callback: NetworkCallback<AuthPostResponse>(
        onLoading: (_) => authResponse.callStatus = NetworkCallStatus.loading,
        onSuccess: onAccessTokenGetSuccess,
        onFailed: onAccessTokenGetFailed,
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
    await context.read<UserNotifier?>()?.logOut();

    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      // GoogleSignInAuthentication? googleAuth =
      //     await googleSignInAccount?.authentication;
      // String? uid = googleSignInAccount?.id;
      // String? accessToken = googleAuth?.accessToken;
      // String? idToken = googleAuth?.idToken;
      String? authCode = googleSignInAccount?.serverAuthCode;

      // Utils.log("google access token = $accessToken");
      // Utils.log("google id token = $idToken");

      if (authCode == null) {
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

      JWT jwt = JWT(
        <String, String?>{
          "uid": authCode,
        },
        issuer: "https://golearningbd.com",
      );

      String oneTimeToken = jwt.sign(
        SecretKey(dotenv.env["GOOGLE_TOKEN_SECRET"]!),
        expiresIn: const Duration(days: 30),
      );

      return const Network().createExecuteCall(
        client: defaultClient,
        requestInterceptors: <NetworkRequestInterceptor>[GuestInterceptor()],
        request: NetworkRequest.post(
          apiEndPoint: signInTokenizePostApiEndpoint,
          body: TokenizeSignInPostRequest(onetimeToken: oneTimeToken).toJson(),
        ),
        responseInterceptors: <NetworkResponseInterceptor<AuthPostResponse>>[
          AuthResponseInterceptor(),
        ],
        responseConverter: const JsonObjectConverter<AuthPostResponse>(
          AuthPostResponse.fromJson,
        ),
        callback: NetworkCallback<AuthPostResponse>(
          onLoading: (_) => authResponse.callStatus = NetworkCallStatus.loading,
          onSuccess: onAccessTokenGetSuccess,
          onFailed: onAccessTokenGetFailed,
          onUpdate: (_) => notifyListeners(),
        ),
        checkCacheFirst: false,
      );
    } catch (e, s) {
      Utils.log("", error: e, stackTrace: s);

      try {
        // ignore: use_build_context_synchronously
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
      requestInterceptors: <NetworkRequestInterceptor>[AuthInterceptor()],
      request: const NetworkRequest.get(
        apiEndPoint: profileGetApiEndpoint,
      ),
      responseConverter: const JsonObjectConverter<ProfileGetResponse>(
        ProfileGetResponse.fromJson,
      ),
      callback: NetworkCallback<ProfileGetResponse>(
        onLoading: (_) => authResponse.callStatus = NetworkCallStatus.loading,
        onSuccess: onProfileGetSuccess,
        onFailed: onProfileGetFailed,
        onUpdate: (_) => notifyListeners(),
      ),
      checkCacheFirst: true,
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

  /// Method to set access token and start getting profile
  void onAccessTokenGetSuccess(NetworkResponse<AuthPostResponse> result) {
    authResponse
      ..copyFrom(result)
      // Set to loading instead of success because we have to get profile now
      ..callStatus = NetworkCallStatus.loading;

    UserBox.setAccessToken(result.result);
    getProfile();
  }

  void onAccessTokenGetFailed(NetworkResponse<AuthPostResponse> result) {
    authResponse
      ..copyFrom(result)
      ..callStatus = NetworkCallStatus.failed;
  }

  void onProfileGetSuccess(NetworkResponse<ProfileGetResponse> result) {
    authResponse
      ..copyFrom(result)
      ..callStatus = NetworkCallStatus.success;
    UserBox.setCurrentUser(result.result?.data);
  }

  void onProfileGetFailed(NetworkResponse<ProfileGetResponse> result) {
    authResponse
      ..copyFrom(result)
      ..callStatus = NetworkCallStatus.failed;
  }
}
