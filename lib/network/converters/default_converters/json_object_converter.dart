import "dart:convert";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/models/base_api_model.dart";

class JsonObjectConverter<D extends BaseApiModel> extends JsonConverter<D, D> {
  const JsonObjectConverter(super.serializer);

  @override
  D fromJsonToDart(String jsonAsString) {
    final Map<String, dynamic> jsonAsMap = json.decode(jsonAsString);
    return serializer.fromJson(jsonAsMap);
  }

  @override
  String fromDartToJson(D dartObject) {
    return json.encode(serializer.toJson(dartObject));
  }
}
