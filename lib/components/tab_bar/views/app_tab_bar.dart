import "package:app/app_config/default_parameters.dart";
import "package:app/components/tab_bar/decoration/default_tab_indicator.dart";
import "package:app/components/tab_bar/views/decorated_tab_bar.dart";
import "package:app/utils/app_colors.dart";
import "package:flutter/material.dart";

typedef OnTabChangeListener = void Function(int index);

class AppTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final OnTabChangeListener onTabChange;
  final Color? bottomBorderColor,
      indicatorColor,
      selectedLabelColor,
      unselectedLabelColor;
  final TextStyle? selectedLabelStyle, unselectedLabelStyle;

  const AppTabBar({
    Key? key,
    required this.tabs,
    required this.onTabChange,
    this.bottomBorderColor,
    this.indicatorColor,
    this.selectedLabelColor,
    this.selectedLabelStyle,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedTabBar(
      bottomBorderColor: bottomBorderColor,
      tabBar: TabBar(
        indicator: DefaultTabIndicator(
          color: indicatorColor ?? DefaultParameters.defaultTabIndicatorColor,
          height: 2,
          radius: 100,
        ),
        labelStyle: selectedLabelStyle ??
            DefaultParameters.defaultTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
        labelColor: selectedLabelColor ?? AppColors.themeBlue,
        unselectedLabelStyle:
            unselectedLabelStyle ?? DefaultParameters.defaultTextStyle,
        unselectedLabelColor:
            unselectedLabelColor ?? AppColors.themeBlue.withOpacity(0.6),
        onTap: onTabChange,
        tabs: tabs,
        labelPadding: EdgeInsets.zero,
      ),
    );
  }
}
