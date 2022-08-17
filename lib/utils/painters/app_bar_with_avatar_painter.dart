import "dart:math" show sqrt, pow;

import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class AppBarWithAvatarPainter extends CustomPainter {
  final double? avatarCenterX, avatarRadius;

  final Color? color;

  const AppBarWithAvatarPainter({
    this.color,
    this.avatarCenterX,
    this.avatarRadius,
  }) : super();

  @override
  void paint(Canvas canvas, Size size) {
    // Validate input values
    double avatarCenterX = this.avatarCenterX ?? Res.dimen.appBarAvatarCenterX;
    double avatarRadius = this.avatarRadius ?? Res.dimen.appBarAvatarRadius;

    // Create paint and path objects and set some properties
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = color ?? Res.color.appBarBg;
    Path path;

    // Calculate points
    Offset topLeft = const Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height);

    if (avatarRadius > 0) {
      // Calculate necessary values
      double avatarHoleFilletRadius =
          avatarRadius * Res.dimen.appBarAvatarToHoleFilletRadiusRatio;
      double avatarHoleRadius =
          avatarRadius * (1 + Res.dimen.appBarAvatarRadiusToHolePaddingRatio);

      Offset avatarHoleCenter = Offset(
        avatarCenterX,
        bottomLeft.dy,
      );

      double filletY = avatarHoleCenter.dy - avatarHoleFilletRadius;
      double tangentY = filletY +
          (pow(avatarHoleFilletRadius, 2) /
              (avatarHoleFilletRadius + avatarHoleRadius));
      double tempDist = sqrt(
        pow(avatarHoleRadius, 2) - pow(avatarHoleCenter.dy - tangentY, 2),
      );
      double leftTangentX = avatarHoleCenter.dx - tempDist;
      double rightTangentX = avatarHoleCenter.dx + tempDist;

      Offset avatarHoleLeftFilletTangent = Offset(leftTangentX, tangentY);
      Offset avatarHoleRightFilletTangent = Offset(rightTangentX, tangentY);

      Offset avatarHoleLeftFilletStart = Offset(
        avatarHoleCenter.dx -
            ((avatarHoleCenter.dx - leftTangentX) *
                (avatarHoleFilletRadius + avatarHoleRadius) /
                avatarHoleRadius),
        bottomLeft.dy,
      );

      Offset avatarHoleRightFilletEnd = Offset(
        avatarHoleCenter.dx +
            ((rightTangentX - avatarHoleCenter.dx) *
                (avatarHoleFilletRadius + avatarHoleRadius) /
                avatarHoleRadius),
        bottomRight.dy,
      );

      // Paint it!
      path = Path()
        ..moveTo(topLeft.dx, topLeft.dy)
        ..lineTo(bottomLeft.dx, bottomLeft.dy)
        ..lineTo(avatarHoleLeftFilletStart.dx, avatarHoleLeftFilletStart.dy)
        ..arcToPoint(
          avatarHoleLeftFilletTangent,
          radius: Radius.circular(avatarHoleFilletRadius),
          clockwise: false,
        )
        ..arcToPoint(
          avatarHoleRightFilletTangent,
          radius: Radius.circular(avatarHoleRadius),
        )
        ..arcToPoint(
          avatarHoleRightFilletEnd,
          radius: Radius.circular(avatarHoleFilletRadius),
          clockwise: false,
        )
        ..lineTo(bottomRight.dx, bottomRight.dy)
        ..lineTo(topRight.dx, topRight.dy)
        ..close();
    } else {
      // Paint it!
      path = Path()
        ..moveTo(topLeft.dx, topLeft.dy)
        ..lineTo(bottomLeft.dx, bottomLeft.dy)
        ..lineTo(bottomRight.dx, bottomRight.dy)
        ..lineTo(topRight.dx, topRight.dy)
        ..close();
    }

    canvas.drawPath(path, paint);
    // canvas.drawShadow(path, Res.color.shadow, 4, true);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
