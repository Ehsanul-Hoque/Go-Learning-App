import "package:app/serializers/serializer.dart";
import "package:app/utils/utils.dart";
import "package:collection/collection.dart" show DeepCollectionEquality;

abstract class BaseApiModel {
  final Serializer<BaseApiModel> serializer;

  const BaseApiModel({required this.serializer});

  @override
  String toString() => Utils.getModelString(className, serializer.toJson(this));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseApiModel &&
          const DeepCollectionEquality().equals(
            serializer.toJson(this),
            other.serializer.toJson(other),
          );

  @override
  int get hashCode => serializer.toJson(this).values.fold<int>(
        0,
        (int previousValue, dynamic element) =>
            previousValue.hashCode ^ element.hashCode,
      );

  String get className;

  /// Default methods
  bool isValid() {
    bool isItValid = false;

    serializer.toJson(this).forEach((String key, dynamic value) {
      if (value != null) {
        isItValid = true;
      }
    });

    return isItValid;
  }
}
