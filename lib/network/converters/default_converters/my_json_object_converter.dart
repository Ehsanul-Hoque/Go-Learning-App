import "dart:convert";

import "package:app/network/converters/my_json_converter.dart";
import "package:app/network/models/api_model.dart";

class MyJsonObjectConverter<D extends ApiModel> extends MyJsonConverter<D, D> {
  const MyJsonObjectConverter(super.fromJson);

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
