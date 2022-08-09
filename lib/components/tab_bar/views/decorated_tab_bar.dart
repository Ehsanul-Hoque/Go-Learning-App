import "package:app/app_config/resources.dart";
import "package:flutter/material.dart";

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar tabBar;
  final bool showBottomBorder;
  final BoxDecoration decoration;

  DecoratedTabBar({
    Key? key,
    required this.tabBar,
    this.showBottomBorder = true,
    Color? bottomBorderColor,
    double? bottomBorderThickness,
  })  : decoration = BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: bottomBorderColor ?? Res.color.tabIndicatorBg,
              width: bottomBorderThickness ??
                  Res.dimen.tabBarBottomBorderThickness,
            ),
          ),
        ),
        super(key: key);

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return showBottomBorder
        ? Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: decoration,
                ),
              ),
              tabBar,
            ],
          )
        : tabBar;
  }
}
