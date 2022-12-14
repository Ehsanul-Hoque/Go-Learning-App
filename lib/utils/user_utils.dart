import "package:app/app_config/resources.dart";
import "package:app/network/models/api_auth/profile_get_response.dart";

class UserUtils {
  static ProfileGetResponseData? _guestUser;

  static ProfileGetResponseData get guestUser =>
      _guestUser ??
      ProfileGetResponseData(
        isGuest: true,
        sId: "guest",
        institution: "",
        enrolledCourses: <String>[],
        verified: false,
        fingerprintToken: <String>[],
        email: "",
        name: Res.str.guest,
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        address: "",
        selectedClass: "",
        phone: "",
        photo: "",
        userType: "",
      );
}
