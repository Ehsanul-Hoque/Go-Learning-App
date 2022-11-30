import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_auth/sign_in_post_request_serializer.dart";

class SignInPostRequestModel extends BaseApiModel {
  final String? email;
  final String? password;
  final String? fingerprintToken;

  const SignInPostRequestModel({
    this.email,
    this.password,
    this.fingerprintToken,
  }) : super(serializer: const SignInPostRequestSerializer());

  @override
  String get className => "SignInPostRequestModel";
}
