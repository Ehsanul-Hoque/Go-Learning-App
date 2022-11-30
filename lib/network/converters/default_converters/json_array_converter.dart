import "dart:convert";

import "package:app/network/converters/json_converter.dart";
import "package:app/network/models/base_api_model.dart";

class JsonArrayConverter<D extends BaseApiModel>
    extends JsonConverter<D, List<D>> {
  const JsonArrayConverter(super.serializer);

  @override
  List<D> fromJsonToDart(String jsonAsString) {
    final List<Map<String, dynamic>> items =
        (json.decode(jsonAsString) as List<dynamic>)
            .map((dynamic item) => item as Map<String, dynamic>)
            .toList();

    final List<D> result = <D>[];
    for (Map<String, dynamic> element in items) {
      result.add(serializer.fromJson(element));
    }

    return result;
  }

  @override
  String fromDartToJson(List<D> dartObject) {
    final List<String> result = <String>[];
    for (D element in dartObject) {
      String jsonAsString = json.encode(serializer.toJson(element));
      result.add(jsonAsString);
    }

    return json.encode(result);
  }
}
