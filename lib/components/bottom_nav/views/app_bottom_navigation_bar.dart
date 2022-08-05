import "package:app/components/bottom_nav/enums/app_bottom_navigation_item_size.dart";
import "package:app/components/bottom_nav/models/app_bottom_navigation_button_model.dart";
import "package:app/components/bottom_nav/views/app_bottom_navigation_item.dart";
import "package:app/utils/app_colors.dart";
import "package:app/app_config/default_parameters.dart";
import "package:flutter/widgets.dart";

class AppBottomNavigationBar extends StatefulWidget {
  final List<AppBottomNavigationBarModel> items;
  final int selectedIndex;
  final Function(int newSelectedIndex) onItemChangeListener;
  final double? width, height;
  final double contentMinWidth;
  final Color backgroundColor, indicatorColor, activeColor, inactiveColor;
  final EdgeInsets indicatorPadding;
  final AppBottomNavigationItemSize itemSize;
  final double flex;
  final Axis itemContentAxis;
  final double spaceBetweenIconAndText;
  final Duration animationDuration;
  final Curve animationCurve;

  const AppBottomNavigationBar({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onItemChangeListener,
    this.width,
    this.height = DefaultParameters.defaultBottomNavBarHeight,
    this.contentMinWidth = DefaultParameters.defaultBottomNavBarContentMinWidth,
    this.backgroundColor = AppColors.white,
    this.indicatorColor = AppColors.themeYellow,
    this.activeColor = AppColors.white,
    this.inactiveColor = AppColors.themeBlue,
    this.indicatorPadding = const EdgeInsets.all(8),
    this.itemSize = AppBottomNavigationItemSize.flex,
    this.flex = 1,
    this.itemContentAxis = Axis.horizontal,
    this.spaceBetweenIconAndText = 4,
    this.animationDuration = DefaultParameters.defaultAnimationDuration,
    this.animationCurve = DefaultParameters.defaultAnimationCurve,
  }) : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedPositioned(
            left: calculateIndicatorLeft(width),
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            child: Container(
              width: calculateItemWidth(width, true),
              height: widget.height,
              padding: widget.indicatorPadding,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                decoration: BoxDecoration(
                  color: widget.items[widget.selectedIndex].indicatorColor ??
                      widget.indicatorColor,
                  borderRadius: DefaultParameters.fullRoundedBorderRadius,
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
                      activeColor:
                          item.contentActiveColor ?? widget.activeColor,
                      inactiveColor:
                          item.contentInactiveColor ?? widget.inactiveColor,
                      width: calculateItemWidth(
                        width,
                        index == widget.selectedIndex,
                      ),
                      height: widget.height,
                      axis: widget.itemContentAxis,
                      spaceBetweenIconAndText: widget.spaceBetweenIconAndText,
                      isSelected: index == widget.selectedIndex,
                      onTap: () => widget.onItemChangeListener(index),
                      animationDuration: widget.animationDuration,
                      animationCurve: widget.animationCurve,
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
        return parentWidth -
            (widget.contentMinWidth * (widget.items.length - 1));
      } else {
        return widget.contentMinWidth;
      }
    }
  }

  double calculateIndicatorLeft(double parentWidth) {
    double itemWidth = calculateItemWidth(parentWidth, false);
    return widget.selectedIndex * itemWidth;
  }
}
