abstract class Serializer<T> {
  const Serializer();

  T fromJson(Map<String, dynamic>? json);

  Map<String, dynamic> toJson(T serializable);
}
