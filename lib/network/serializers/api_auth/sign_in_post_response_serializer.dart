import "package:app/network/models/api_auth/sign_in_post_response_model.dart";
import "package:app/serializers/serializer.dart";

class SignInPostResponseSerializer extends Serializer<SignInPostResponseModel> {
  const SignInPostResponseSerializer();

  @override
  SignInPostResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SignInPostResponseModel();

    return SignInPostResponseModel(
      xAccessToken: json["x-access-token"],
      msg: json["msg"],
    );
  }

  @override
  Map<String, dynamic> toJson(SignInPostResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["x-access-token"] = serializable.xAccessToken;
    data["msg"] = serializable.msg;

    return data;
  }
}
