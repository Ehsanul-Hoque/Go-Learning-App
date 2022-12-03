import "package:app/utils/utils.dart";
import "package:collection/collection.dart" show DeepCollectionEquality;

abstract class ApiModel {
  const ApiModel();

  @override
  String toString() => Utils.getModelString(runtimeType.toString(), toJson());

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiModel &&
          const DeepCollectionEquality().equals(toJson(), other.toJson());

  @override
  int get hashCode => toJson().values.fold<int>(
        0,
        (int previousValue, dynamic element) =>
            previousValue.hashCode ^ element.hashCode,
      );

  Map<String, dynamic> toJson();
  // String get className => runtimeType.toString();

  /// Default methods
  bool isValid() {
    bool isItValid = false;

    toJson().forEach((String key, dynamic value) {
      if (value != null) {
        isItValid = true;
      }
    });

    return isItValid;
  }
}
