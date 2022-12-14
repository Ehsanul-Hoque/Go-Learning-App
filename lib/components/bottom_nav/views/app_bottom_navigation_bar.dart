import "dart:math" show min;

import "package:app/app_config/resources.dart";
import "package:app/components/bottom_nav/enums/app_bottom_navigation_item_size.dart";
import "package:app/components/bottom_nav/models/app_bottom_navigation_button_model.dart";
import "package:app/components/bottom_nav/views/app_bottom_navigation_item.dart";
import "package:app/utils/typedefs.dart" show OnItemChangeListener;
import "package:flutter/widgets.dart";

class AppBottomNavigationBar extends StatefulWidget {
  final List<AppBottomNavigationBarModel> items;
  final int selectedIndex;
  final OnItemChangeListener onItemChange;
  final double? width, height;
  final bool showOnlyIconForInactiveItem;
  final double? contentMinWidth;
  final Color? backgroundColor, indicatorColor, activeColor, inactiveColor;
  final EdgeInsets? indicatorPadding;
  final BorderRadius? indicatorBorderRadius;
  final AppBottomNavigationItemSize itemSize;
  final double flex;
  final Axis itemContentAxis;
  final double? spaceBetweenIconAndText;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const AppBottomNavigationBar({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemChange,
    this.width,
    this.height,
    this.showOnlyIconForInactiveItem = true,
    this.contentMinWidth,
    this.backgroundColor,
    this.indicatorColor,
    this.activeColor,
    this.inactiveColor,
    this.indicatorPadding,
    this.indicatorBorderRadius,
    this.itemSize = AppBottomNavigationItemSize.flex,
    this.flex = 1,
    this.itemContentAxis = Axis.horizontal,
    this.spaceBetweenIconAndText,
    this.animationDuration,
    this.animationCurve,
  }) : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late double width, height;
  late double contentMinWidth;
  late Color backgroundColor, indicatorColor, activeColor, inactiveColor;
  late EdgeInsets indicatorPadding;
  late BorderRadius indicatorBorderRadius;
  late Duration animationDuration;
  late Curve animationCurve;

  @override
  void initState() {
    height = widget.height ?? Res.dimen.bottomNavBarHeight;
    contentMinWidth =
        widget.contentMinWidth ?? Res.dimen.bottomNavBarContentMinWidth;

    backgroundColor = widget.backgroundColor ?? Res.color.bottomNavBg;
    indicatorColor = widget.indicatorColor ?? Res.color.bottomNavIndicator;
    activeColor = widget.activeColor ?? Res.color.bottomNavItemActive;
    inactiveColor = widget.inactiveColor ?? Res.color.bottomNavItemInactive;

    indicatorPadding =
        widget.indicatorPadding ?? EdgeInsets.all(Res.dimen.smallSpacingValue);
    indicatorBorderRadius = widget.indicatorBorderRadius ??
        BorderRadius.circular(
          Res.dimen.fullRoundedBorderRadiusValue,
        );

    animationDuration =
        widget.animationDuration ?? Res.durations.defaultDuration;
    animationCurve = widget.animationCurve ?? Res.curves.defaultCurve;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = widget.width ??
        min(
          MediaQuery.of(context).size.width - (Res.dimen.navBarMargin * 2),
          400,
        );

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(Res.dimen.navBarMargin),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            BorderRadius.circular(Res.dimen.fullRoundedBorderRadiusValue),
        boxShadow: <BoxShadow>[
          Res.shadows.normal,
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedPositioned(
            left: calculateIndicatorLeft(width),
            duration: animationDuration,
            curve: animationCurve,
            child: Container(
              width: calculateItemWidth(width, true),
              height: height,
              padding: indicatorPadding,
              child: AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                decoration: BoxDecoration(
                  color: widget.items[widget.selectedIndex].indicatorColor ??
                      indicatorColor,
                  borderRadius: indicatorBorderRadius,
                ),
              ),
            ),
          ),
          Row(
            children: widget.items
                .asMap()
                .map((int index, AppBottomNavigationBarModel item) {
                  return MapEntry<int, Widget>(
                    index,
                    AppBottomNavigationItem(
                      icon: item.icon,
                      text: item.text,
                      showOnlyIconForInactiveItem:
                          widget.showOnlyIconForInactiveItem,
                      activeColor: item.contentActiveColor ?? activeColor,
                      inactiveColor: item.contentInactiveColor ?? inactiveColor,
                      width: calculateItemWidth(
                        width,
                        index == widget.selectedIndex,
                      ),
                      padding: indicatorPadding,
                      axis: widget.itemContentAxis,
                      spaceBetweenIconAndText: widget.spaceBetweenIconAndText,
                      isSelected: index == widget.selectedIndex,
                      onTap: () => widget.onItemChange(index),
                      animationDuration: animationDuration,
                      animationCurve: animationCurve,
                    ),
                  );
                })
                .values
                .toList(),
          ),
        ],
      ),
    );
  }

  double calculateItemWidth(double parentWidth, bool isSelected) {
    if (widget.itemSize == AppBottomNavigationItemSize.flex) {
      double totalFlex = widget.flex + (widget.items.length - 1);
      // return parentWidth / widget.items.length;
      if (isSelected) {
        return (parentWidth / totalFlex) * widget.flex;
      } else {
        return parentWidth / totalFlex;
      }
    } else {
      if (isSelected) {
        return parentWidth - (contentMinWidth * (widget.items.length - 1));
      } else {
        return contentMinWidth;
      }
    }
  }

  double calculateIndicatorLeft(double parentWidth) {
    double itemWidth = calculateItemWidth(parentWidth, false);
    return widget.selectedIndex * itemWidth;
  }
}
