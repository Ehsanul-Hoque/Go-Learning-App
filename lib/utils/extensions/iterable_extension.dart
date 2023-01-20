import "dart:math";

extension IterableExt<T> on Iterable<T?> {
  // T? operator [](int index) => length > index ? elementAt(index) : null;

  T? elementAtOrNull(int index) =>
      ((index >= 0) && (index < length)) ? elementAt(index) : null;

  T? getRandom() {
    final Random random = Random();
    return elementAt(random.nextInt(length));
  }

  List<T?> getRandoms(int length) {
    List<T?> result = <T?>[];
    for (int i = 0; i < length; ++i) {
      result.add(getRandom());
    }
    return result;
  }

  List<T> getNonNullRandoms(int length) {
    Iterable<T> nonNulls = getNonNulls();
    if (nonNulls.isEmpty) return <T>[];

    List<T> result = <T>[];
    for (int i = 0; i < length; ++i) {
      result.add(nonNulls.getRandom() as T);
    }

    return result;
  }

  Iterable<T> getNonNulls() {
    List<T> result = <T>[];
    for (int i = 0; i < length; ++i) {
      T? element = elementAt(i);
      if (element != null) {
        result.add(element);
      }
    }
    return result;
  }
}
