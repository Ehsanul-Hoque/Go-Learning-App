import "package:app/serializers/serializer.dart";

class SerializerHelper {
  // Object helpers
  static T? jsonToModelObject<T>(dynamic jsonObject, Serializer<T> serializer) {
    return (jsonObject != null) ? serializer.fromJson(jsonObject) : null;
  }

  static Map<String, dynamic>? modelToJsonObject<T>(
    T? modelObject,
    Serializer<T> serializer,
  ) {
    return (modelObject == null) ? null : serializer.toJson(modelObject);
  }

  // List helpers
  static List<T?>? jsonToTypedList<T>(dynamic jsonList) {
    return (jsonList as List<dynamic>?)
        ?.map((dynamic item) => item as T?)
        .toList();
  }

  static List<T?>? jsonToModelList<T>(
    dynamic jsonList,
    Serializer<T> serializer,
  ) {
    return (jsonList as List<dynamic>?)
        ?.map((dynamic item) => item as Map<String, dynamic>?)
        .map(
          (Map<String, dynamic>? item) =>
              (item == null) ? null : serializer.fromJson(item),
        )
        .toList();
  }

  static List<Map<String, dynamic>?>? modelToJsonList<T>(
    List<T?>? modelList,
    Serializer<T> serializer,
  ) {
    return modelList
        ?.map((T? item) => (item == null) ? null : serializer.toJson(item))
        .toList();
  }
}
