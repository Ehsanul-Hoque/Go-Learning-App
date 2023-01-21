import "dart:math" as math show max;

extension LogExtension on double {
  String getCompactString([int fractionDigits = 2]) {
    double intRepresentation = toInt().toDouble();
    return (this == intRepresentation)
        ? toStringAsFixed(0)
        : toStringAsFixed(math.max(fractionDigits, 0));
  }
}
