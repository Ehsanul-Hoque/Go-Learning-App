import "dart:convert";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/models/api_model.dart";

class JsonArrayConverter<D extends ApiModel> extends JsonConverter<D, List<D>> {
  const JsonArrayConverter(super.fromJson);

  @override
  List<D> fromJsonToDart(String jsonAsString) {
    final List<Map<String, dynamic>> items =
        (json.decode(jsonAsString) as List<dynamic>)
            .map((dynamic item) => item as Map<String, dynamic>)
            .toList();

    final List<D> result = <D>[];
    for (Map<String, dynamic> element in items) {
      result.add(fromJson(element));
    }

    return result;
  }

  @override
  String fromDartToJson(List<D> dartObject) {
    final List<String> result = <String>[];
    for (D element in dartObject) {
      String jsonAsString = json.encode(element.toJson());
      result.add(jsonAsString);
    }

    return json.encode(result);
  }
}
