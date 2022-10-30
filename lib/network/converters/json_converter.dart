import "package:app/serializers/serializer.dart";

/// DI => Dart object (input)
/// DO => Dart object (output)
abstract class JsonConverter<DI, DO> {
  const JsonConverter();

  DO fromJsonToDart(String jsonAsString, Serializer<DI> serializer);

  String fromDartToJson(DO dartObject, Serializer<DI> serializer);
}
