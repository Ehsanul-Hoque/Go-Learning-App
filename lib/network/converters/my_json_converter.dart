/// DI => Dart object (input)
/// DO => Dart object (output)
abstract class MyJsonConverter<DI, DO> {
  /// Constructor
  const MyJsonConverter(this.fromJson);

  /// Method to convert Map to Dart object
  final DI Function(Map<String, dynamic>) fromJson;

  /// Method to convert JSON string to Dart object using the serializer
  DO fromJsonToDart(String jsonAsString);

  /// Method to convert Dart object to JSON string using the serializer
  String fromDartToJson(DO dartObject);
}
