import "package:app/app_config/colors/app_colors.dart";
import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class PriceBgPainter extends CustomPainter {
  final Color? color;

  PriceBgPainter({
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = AppColors.white;

    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = color ?? Res.color.priceBg;

    Offset topLeft = Offset(size.height / 1.5, 0);
    Offset bottomLeft = Offset(0, size.height);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height);

    Path path = Path()
      ..moveTo(topLeft.dx, topLeft.dy)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..lineTo(bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, bgPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
