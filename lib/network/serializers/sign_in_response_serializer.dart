import "package:app/network/models/api_auth/sign_in_response_model.dart";
import "package:app/serializers/serializer.dart";

class SignInResponseSerializer extends Serializer<SignInResponseModel> {
  const SignInResponseSerializer();

  @override
  SignInResponseModel fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SignInResponseModel();

    return SignInResponseModel(
      xAccessToken: json["x-access-token"],
      msg: json["msg"],
    );
  }

  @override
  Map<String, dynamic> toJson(SignInResponseModel serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["x-access-token"] = serializable.xAccessToken;
    data["msg"] = serializable.msg;

    return data;
  }
}
