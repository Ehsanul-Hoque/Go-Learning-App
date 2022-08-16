import "dart:math";

extension Subscript<T> on Iterable<T> {
  // T? operator [](int index) => length > index ? elementAt(index) : null;

  T getRandom() {
    final Random random = Random();
    return elementAt(random.nextInt(length));
  }

  Iterable<T> getRandoms(int length) {
    List<T> result = <T>[];
    for (int i = 0; i < length; ++i) {
      result.add(getRandom());
    }
    return result;
  }
}
