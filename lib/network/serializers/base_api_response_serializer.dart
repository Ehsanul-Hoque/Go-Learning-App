import "package:app/network/models/base_api_response_model.dart";
import "package:app/serializers/serializer.dart";

class BaseApiResponseSerializer<T> extends Serializer<BaseApiResponseModel<T>> {
  final Serializer<T> datumObjectSerializer;

  const BaseApiResponseSerializer(this.datumObjectSerializer);

  @override
  BaseApiResponseModel<T> fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return BaseApiResponseModel<T>(
        datumObjectSerializer: datumObjectSerializer,
      );
    }

    return BaseApiResponseModel<T>(
      datumObjectSerializer: datumObjectSerializer,
      success: json["success"],
      data: (json["data"] as List<dynamic>?)
          ?.map((dynamic datum) => datum as Map<String, dynamic>?)
          .map(
            (Map<String, dynamic>? datum) =>
                (datum == null) ? null : datumObjectSerializer.fromJson(datum),
          )
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(BaseApiResponseModel<T> serializable) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["success"] = serializable.success;
    data["data"] = serializable.data
        ?.map(
          (T? datum) =>
              (datum == null) ? null : datumObjectSerializer.toJson(datum),
        )
        .toList();

    return data;
  }
}
