import "package:app/serializers/serializer.dart";

/// DI => Dart object (input)
/// DO => Dart object (output)
abstract class JsonConverter<DI, DO> {
  /// Constructor
  const JsonConverter(this.serializer);

  /// Serializer object for the input JSON
  final Serializer<DI> serializer;

  /// Method to convert JSON string to Dart object using the serializer
  DO fromJsonToDart(String jsonAsString);

  /// Method to convert Dart object to JSON string using the serializer
  String fromDartToJson(DO dartObject);
}
