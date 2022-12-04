import "package:app/local_storage/app_objectbox.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";
import "package:app/objectbox.g.dart";
import "package:app/utils/extensions/iterable_extension.dart";

class UserBox {
  static void setCurrentUser(ProfileGetResponseData? profileData) {
    Box<ProfileGetResponseData> userBox =
        appObjectBox.store.box<ProfileGetResponseData>();

    if (profileData == null) {
      userBox.removeAll();
      return;
    }

    if (!userBox.isEmpty()) {
      profileData.boxId = userBox.getAll()[0].boxId;
    }

    userBox.put(profileData);
  }

  static ProfileGetResponseData? getCurrentUser() {
    Box<ProfileGetResponseData> userBox =
        appObjectBox.store.box<ProfileGetResponseData>();

    return userBox.getAll().elementAtOrNull(0);
  }

  static void logOut() => setCurrentUser(null);
}
