import "dart:convert";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/models/api_model.dart";

class JsonObjectConverter<D extends ApiModel> extends JsonConverter<D, D> {
  const JsonObjectConverter(super.fromJson);

  @override
  D fromJsonToDart(String jsonAsString) {
    final Map<String, dynamic> jsonAsMap = json.decode(jsonAsString);
    return fromJson(jsonAsMap);
  }

  @override
  String fromDartToJson(D dartObject) {
    return json.encode(dartObject.toJson());
  }
}
