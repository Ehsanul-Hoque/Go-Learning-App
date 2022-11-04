import "package:flutter/widgets.dart";

class SliverSizedBox extends StatelessWidget {
  final double? width, height;
  final Widget? child;

  const SliverSizedBox({
    Key? key,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  const SliverSizedBox.shrink({
    Key? key,
  })  : width = 0,
        height = 0,
        child = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
