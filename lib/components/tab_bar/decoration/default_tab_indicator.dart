import "package:flutter/widgets.dart";

class DefaultTabIndicator extends Decoration {
  final Color color;
  final double height;
  final double radius;

  const DefaultTabIndicator({
    required this.color,
    required this.height,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DefaultTabIndicatorPainter(color, height, radius);
  }
}

class _DefaultTabIndicatorPainter extends BoxPainter {
  final Color color;
  final double height;
  final double radius;

  const _DefaultTabIndicatorPainter(
    this.color,
    this.height,
    this.radius,
  );

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    paint.isAntiAlias = true;

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    final Rect rect =
        (offset + Offset(0, configuration.size!.height - height)) &
            Size(configuration.size!.width, height);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      ),
      paint,
    );
  }
}
