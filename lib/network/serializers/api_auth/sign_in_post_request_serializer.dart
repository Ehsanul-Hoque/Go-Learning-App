import "package:app/network/models/api_auth/sign_in_post_request_model.dart";
import "package:app/serializers/serializer.dart";

class SignInPostRequestSerializer extends Serializer<SignInPostRequestModel> {
  const SignInPostRequestSerializer();

  @override
  SignInPostRequestModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SignInPostRequestModel();

    return SignInPostRequestModel(
      email: json["email"],
      password: json["password"],
      fingerprintToken: json["fingerprint_token"],
    );
  }

  @override
  Map<String, dynamic> toJson(SignInPostRequestModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["email"] = serializable.email;
    data["password"] = serializable.password;
    data["fingerprint_token"] = serializable.fingerprintToken;

    return data;
  }
}
