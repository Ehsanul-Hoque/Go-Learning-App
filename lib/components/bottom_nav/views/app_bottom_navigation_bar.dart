import 'package:app/components/bottom_nav/enums/app_bottom_navigation_item_size.dart';
import 'package:app/components/bottom_nav/models/app_bottom_navigation_button_model.dart';
import 'package:app/components/bottom_nav/views/app_bottom_navigation_item.dart';
import 'package:app/utils/app_colors.dart';
import 'package:app/utils/app_parameters.dart';
import 'package:flutter/widgets.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final List<AppBottomNavigationBarModel> items;
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
    this.width,
    this.height = AppParameters.defaultBottomNavBarHeight,
    this.contentMinWidth = AppParameters.defaultBottomNavBarContentMinWidth,
    this.backgroundColor = AppColors.white,
    this.indicatorColor = AppColors.themeYellow,
    this.activeColor = AppColors.white,
    this.inactiveColor = AppColors.themeBlue,
    this.indicatorPadding = const EdgeInsets.all(8),
    this.itemSize = AppBottomNavigationItemSize.flex,
    this.flex = 1,
    this.itemContentAxis = Axis.horizontal,
    this.spaceBetweenIconAndText = 4,
    this.animationDuration = AppParameters.defaultAnimationDuration,
    this.animationCurve = AppParameters.defaultAnimationCurve,
  }) : super(key: key);

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                  color: widget.items[_selectedIndex].indicatorColor ??
                      widget.indicatorColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
          Row(
            children: widget.items
                .asMap()
                .map((int index, AppBottomNavigationBarModel item) {
                  return MapEntry(
                    index,
                    AppBottomNavigationItem(
                      icon: item.icon,
                      text: item.text,
                      activeColor:
                          item.contentActiveColor ?? widget.activeColor,
                      inactiveColor:
                          item.contentInactiveColor ?? widget.inactiveColor,
                      width: calculateItemWidth(width, index == _selectedIndex),
                      height: widget.height,
                      axis: widget.itemContentAxis,
                      spaceBetweenIconAndText: widget.spaceBetweenIconAndText,
                      isSelected: index == _selectedIndex,
                      onTap: () {
                        onItemTap(index);
                      },
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
    return _selectedIndex * itemWidth;
  }

  void onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
