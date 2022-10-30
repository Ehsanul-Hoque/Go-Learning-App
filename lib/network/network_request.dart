import "package:app/network/converters/json_converter.dart";
import "package:app/network/enums/network_call_type.dart";
import "package:app/serializers/serializer.dart";

/// DI => Dart object (input) (for serializer)
/// DO => Dart object (output) (for the final output)
class NetworkRequest<DI, DO> {
  final NetworkCallType callType;
  final String apiEndPoint;
  final Serializer<DI> serializer;
  final JsonConverter<DI, DO> converter;
  final String? baseUrl;
  final Map<String, String>? headers;

  const NetworkRequest({
    required this.callType,
    required this.apiEndPoint,
    required this.serializer,
    required this.converter,
    this.baseUrl,
    this.headers,
  });

  const NetworkRequest.get({
    required this.apiEndPoint,
    required this.serializer,
    required this.converter,
    this.baseUrl,
    this.headers,
  }) : callType = NetworkCallType.get;

  const NetworkRequest.post({
    required this.apiEndPoint,
    required this.serializer,
    required this.converter,
    this.baseUrl,
    this.headers,
  }) : callType = NetworkCallType.post;
}
