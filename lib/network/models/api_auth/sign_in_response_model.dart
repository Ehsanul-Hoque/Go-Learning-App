import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_auth/sign_in_response_serializer.dart";

class SignInResponseModel extends BaseApiModel {
  final String? xAccessToken;
  final String? msg;

  const SignInResponseModel({this.xAccessToken, this.msg})
      : super(serializer: const SignInResponseSerializer());

  @override
  String get className => "SignInResponseModel";
}
