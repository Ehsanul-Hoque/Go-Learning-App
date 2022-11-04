import "package:app/utils/typedefs.dart" show IndexedItemBuilder;
import "package:flutter/widgets.dart";

class ColumnRowGrid extends StatelessWidget {
  final int itemCount, crossAxisCount;
  final double itemWidth, itemHeight, mainAxisSpacing, crossAxisSpacing;
  final IndexedItemBuilder itemBuilder;

  const ColumnRowGrid({
    Key? key,
    required this.itemCount,
    required this.crossAxisCount,
    required this.itemWidth,
    required this.itemHeight,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.itemBuilder,
  })  : assert(itemCount >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < itemCount; i += crossAxisCount) ...<Widget>[
          Row(
            children: <Widget>[
              for (int j = 0; j < crossAxisCount; ++j)
                if ((i + j) < itemCount) ...<Widget>[
                  SizedBox(
                    width: itemWidth,
                    height: itemHeight,
                    child: itemBuilder(context, i + j),
                  ),
                  if (j < crossAxisCount - 1)
                    SizedBox(
                      width: crossAxisSpacing,
                    ),
                ],
            ],
          ),
          if (i < itemCount - 1)
            SizedBox(
              height: mainAxisSpacing,
            ),
        ],
      ],
    );
  }
}
