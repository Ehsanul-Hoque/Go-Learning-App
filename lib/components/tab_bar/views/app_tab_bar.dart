import "package:app/app_config/resources.dart";
import "package:app/components/tab_bar/decoration/default_tab_indicator.dart";
import "package:app/components/tab_bar/views/decorated_tab_bar.dart";
import "package:app/utils/typedefs.dart" show OnTabChangeListener;
import "package:flutter/material.dart";

class AppTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final OnTabChangeListener onTabChange;
  final Color? bottomBorderColor,
      indicatorColor,
      selectedLabelColor,
      unselectedLabelColor;
  final double? indicatorHeight;
  final BorderRadius? indicatorBorderRadius;
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
    this.indicatorHeight,
    this.indicatorBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedTabBar(
      bottomBorderColor: bottomBorderColor,
      tabBar: TabBar(
        indicator: DefaultTabIndicator(
          color: indicatorColor,
          height: indicatorHeight,
          radius: indicatorBorderRadius,
        ),
        labelStyle: selectedLabelStyle ?? Res.textStyles.tabSelectedLabel,
        labelColor: selectedLabelColor ?? Res.color.tabSelectedLabel,
        unselectedLabelStyle: unselectedLabelStyle ?? Res.textStyles.general,
        unselectedLabelColor: unselectedLabelColor ?? Res.color.tabLabel,
        onTap: onTabChange,
        tabs: tabs,
        labelPadding: EdgeInsets.zero,
      ),
    );
  }
}
