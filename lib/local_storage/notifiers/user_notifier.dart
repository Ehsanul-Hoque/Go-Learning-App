import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/models/api_auth/sign_in_post_response.dart";
import "package:app/network/notifiers/auth_api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext, ChangeNotifier;
import "package:provider/provider.dart"
    show ChangeNotifierProvider, ReadContext;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class UserNotifier extends ChangeNotifier {
  /// Constructor
  UserNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<UserNotifier>(
        create: (BuildContext context) => UserNotifier(),
      );

  /// Method to set the current user access token
  void setAccessToken(SignInPostResponse? signInResponse) {
    UserBox.setAccessToken(signInResponse);
    notifyListeners();
  }

  /// Method to set the current user access token from the sign in response
  void setAccessTokenFromSignInResponse(BuildContext context) {
    setAccessToken(
      context.read<AuthApiNotifier>().signInWithEmailPasswordResponse.result,
    );
  }

  /// Method to set the current user
  void setCurrentUser(ProfileGetResponseData? profileData) {
    UserBox.setCurrentUser(profileData);
    notifyListeners();
  }

  /// Getter method to get the current user access token
  String? get accessToken => UserBox.accessToken;

  /// Getter method to get the current user
  ProfileGetResponseData? get currentUser => UserBox.currentUser;

  /// Getter method to check if any access token is currently saved.
  bool get hasAccessToken => UserBox.hasAccessToken;

  /// Getter method to check if any user is logged in currently
  bool get isLoggedIn => UserBox.isLoggedIn;

  /// Method to log out
  void logOut() {
    UserBox.logOut();
    notifyListeners();
  }
}
