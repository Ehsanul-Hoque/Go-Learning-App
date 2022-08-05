import "package:app/utils/app_colors.dart";
import "package:flutter/widgets.dart";

class AppDivider extends StatelessWidget {
  final Axis axis;
  final double thickness;
  final Color color;
  final EdgeInsets margin;

  const AppDivider({
    Key? key,
    this.axis = Axis.horizontal,
    this.thickness = 1,
    this.color = AppColors.grey300,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: axis == Axis.horizontal ? null : thickness,
      height: axis == Axis.horizontal ? thickness : null,
      margin: margin,
      color: color,
    );
  }
}
