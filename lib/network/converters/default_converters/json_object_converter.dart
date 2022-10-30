import "dart:convert";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/models/base_api_model.dart";
import "package:app/serializers/serializer.dart";

class JsonObjectConverter<D extends BaseApiModel>
    implements JsonConverter<D, D> {
  const JsonObjectConverter();

  @override
  D fromJsonToDart(String jsonAsString, Serializer<D> serializer) {
    final Map<String, dynamic> jsonAsMap = json.decode(jsonAsString);
    return serializer.fromJson(jsonAsMap);
  }

  @override
  String fromDartToJson(D dartObject, Serializer<D> serializer) {
    return json.encode(serializer.toJson(dartObject));
  }
}
