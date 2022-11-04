import "package:flutter/widgets.dart";

class SliverSizedBox extends StatelessWidget {
  final double? width, height;

  const SliverSizedBox({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  const SliverSizedBox.shrink({
    Key? key,
  })  : width = 0,
        height = 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        width: width,
        height: height,
      ),
    );
  }
}
