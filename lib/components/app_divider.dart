import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class AppDivider extends StatelessWidget {
  final Axis axis;
  final double? mainAxisSize;
  final double? thickness;
  final Color? color;
  final EdgeInsets margin;

  const AppDivider({
    Key? key,
    this.axis = Axis.horizontal,
    this.mainAxisSize,
    this.thickness,
    this.color,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double thickness = this.thickness ?? Res.dimen.defaultBorderThickness;

    return Container(
      width: axis == Axis.horizontal ? mainAxisSize : thickness,
      height: axis == Axis.horizontal ? thickness : mainAxisSize,
      margin: margin,
      color: color ?? Res.color.divider,
    );
  }
}
