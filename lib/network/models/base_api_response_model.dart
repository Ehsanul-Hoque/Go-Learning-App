import "package:app/network/models/base_api_model.dart";
import "package:app/network/serializers/base_api_response_serializer.dart";
import "package:app/serializers/serializer.dart";

class BaseApiResponseModel<T> extends BaseApiModel {
  final String? success;
  final List<T?>? data;

  BaseApiResponseModel({
    this.success,
    this.data,
    required Serializer<T> datumObjectSerializer,
  }) : super(serializer: BaseApiResponseSerializer<T>(datumObjectSerializer));

  @override
  String get className => "BaseApiResponseModel<$T>";
}
