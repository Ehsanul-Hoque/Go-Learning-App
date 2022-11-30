import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/api_auth/sign_in_post_response_serializer.dart";

class SignInPostResponseModel extends BaseApiModel {
  final String? xAccessToken;
  final String? msg;

  const SignInPostResponseModel({this.xAccessToken, this.msg})
      : super(serializer: const SignInPostResponseSerializer());

  @override
  String get className => "SignInPostResponseModel";
}
