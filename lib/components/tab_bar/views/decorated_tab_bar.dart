import "package:app/app_config/default_parameters.dart";
import "package:flutter/material.dart";

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar tabBar;
  final BoxDecoration decoration;

  DecoratedTabBar({
    Key? key,
    required this.tabBar,
    Color? bottomBorderColor,
  })  : decoration = BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: bottomBorderColor ??
                  DefaultParameters.defaultTabIndicatorBgColor,
              width: 1,
            ),
          ),
        ),
        super(key: key);

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: decoration,
          ),
        ),
        tabBar,
      ],
    );
  }
}
