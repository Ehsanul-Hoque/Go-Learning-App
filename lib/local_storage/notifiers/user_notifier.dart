import "package:app/local_storage/boxes/userbox.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/network/notifiers/api_notifier.dart";
import "package:flutter/widgets.dart" show BuildContext;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart" show SingleChildWidget;

class UserNotifier extends ApiNotifier {
  /// Constructor
  UserNotifier();

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<UserNotifier>(
        create: (BuildContext context) => UserNotifier(),
      );

  /// Method to set the current user
  void setCurrentUser(ProfileGetResponseData? profileData) {
    UserBox.setCurrentUser(profileData);
    notifyListeners();
  }

  /// Method to get the current user
  ProfileGetResponseData? getCurrentUser() => UserBox.getCurrentUser();

  /// Method to log out
  void logOut() {
    UserBox.logOut();
    notifyListeners();
  }
}
