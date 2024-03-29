import "package:app/app_config/app_state.dart";
import "package:app/local_storage/app_objectbox.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/models/api_auth/auth_post_response.dart";
import "package:app/network/network.dart";
import "package:app/network/notifiers/auth_api_notifier.dart" show googleSignIn;
import "package:app/objectbox.g.dart";
import "package:app/utils/extensions/iterable_extension.dart";

class UserBox {
  static void setAccessToken(AuthPostResponse? signInResponse) {
    Box<AuthPostResponse> box = appObjectBox.store.box<AuthPostResponse>();

    if (signInResponse == null) {
      box.removeAll();
      return;
    }

    if (!box.isEmpty()) {
      signInResponse.boxId = box.getAll()[0].boxId;
    }

    box.put(signInResponse);
  }

  static void setCurrentUser(ProfileGetResponseData? profileData) {
    Box<ProfileGetResponseData> box =
        appObjectBox.store.box<ProfileGetResponseData>();

    if (profileData == null) {
      box.removeAll();
      return;
    }

    if (!box.isEmpty()) {
      profileData.boxId = box.getAll()[0].boxId;
    }

    box.put(profileData);
  }

  static AuthPostResponse? get accessTokenResponse =>
      appObjectBox.store.box<AuthPostResponse>().getAll().elementAtOrNull(0);

  static String? get accessToken => appObjectBox.store
      .box<AuthPostResponse>()
      .getAll()
      .elementAtOrNull(0)
      ?.xAccessToken;

  static ProfileGetResponseData? get currentUser => appObjectBox.store
      .box<ProfileGetResponseData>()
      .getAll()
      .elementAtOrNull(0);

  static bool get isLoggedIn {
    String? token = accessToken;
    return (token != null) && token.isNotEmpty;
  }

  static bool get hasProfileInfo => isLoggedIn && (currentUser != null);

  static Future<void> logOut({bool resetNetworkCalls = true}) async {
    if (resetNetworkCalls) {
      AppState.generateNewSessionKey();
      Network.resetAllResponses();
    }

    setAccessToken(null);
    setCurrentUser(null);
    await googleSignIn.signOut();
  }
}
