import "package:app/app_config/resources.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/components/bottom_nav/views/app_bottom_navigation_item_text.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/widgets.dart";

class AppBottomNavigationItem extends StatefulWidget {
  final double? width, height;
  final EdgeInsets padding;
  final double? spaceBetweenIconAndText;
  final OnTapListener onTap;
  final Widget icon;
  final String text;
  final double? textSize;
  final bool showOnlyIconForInactiveItem;
  final Axis axis;
  final bool isSelected;
  final Color? backgroundColor, activeColor, inactiveColor;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const AppBottomNavigationItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.textSize,
    this.showOnlyIconForInactiveItem = true,
    this.axis = Axis.horizontal,
    this.spaceBetweenIconAndText,
    this.isSelected = false,
    this.animationDuration,
    this.animationCurve,
  })  : assert(
          (axis == Axis.horizontal && width != null) ||
              (axis == Axis.vertical && height != null),
        ),
        super(key: key);

  @override
  State<AppBottomNavigationItem> createState() =>
      _AppBottomNavigationItemState();
}

class _AppBottomNavigationItemState extends State<AppBottomNavigationItem>
    with SingleTickerProviderStateMixin {
  late Duration animationDuration;
  late Curve animationCurve;

  late double iconSize, textSize;
  late double spaceBetweenIconAndText;
  late EdgeInsets padding;
  late Color backgroundColor, activeColor, inactiveColor;

  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    animationDuration =
        widget.animationDuration ?? Res.durations.defaultDuration;
    animationCurve = widget.animationCurve ?? Res.curves.defaultCurve;

    textSize = widget.textSize ?? Res.dimen.fontSizeNormal;
    spaceBetweenIconAndText =
        widget.spaceBetweenIconAndText ?? Res.dimen.xsSpacingValue;
    padding = EdgeInsets.only(
      left: widget.padding.left + Res.dimen.xsSpacingValue,
      top: widget.padding.top + Res.dimen.xsSpacingValue,
      right: widget.padding.right + Res.dimen.xsSpacingValue,
      bottom: widget.padding.bottom + Res.dimen.xsSpacingValue,
    );
    backgroundColor = widget.backgroundColor ?? Res.color.bottomNavItemBg;
    activeColor = widget.activeColor ?? Res.color.bottomNavItemActive;
    inactiveColor = widget.inactiveColor ?? Res.color.bottomNavItemInactive;

    _animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: animationCurve,
    );

    _colorAnimation = ColorTween(
      begin: inactiveColor,
      end: activeColor,
    ).animate(_curvedAnimation);

    if (widget.isSelected) {
      _animationController.forward();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppBottomNavigationItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: animationDuration,
        curve: animationCurve,
        width: widget.width,
        height: widget.height,
        padding: padding,
        color: backgroundColor,
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (BuildContext context, Widget? child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                _colorAnimation.value ?? inactiveColor,
                BlendMode.srcATop,
              ),
              child: child,
            );
          },
          child: Flex(
            direction: widget.axis,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.icon,
              widget.showOnlyIconForInactiveItem
                  ? AnimatedSizeContainer(
                      animateForward: widget.isSelected,
                      animateOnInit: true,
                      axisAlignment: 1,
                      axis: widget.axis,
                      child: AppBottomNavigationItemText(
                        spaceBetweenIconAndText: spaceBetweenIconAndText,
                        navItemAxis: widget.axis,
                        text: widget.text,
                        textSize: textSize,
                      ),
                    )
                  : AppBottomNavigationItemText(
                      spaceBetweenIconAndText: spaceBetweenIconAndText,
                      navItemAxis: widget.axis,
                      text: widget.text,
                      textSize: textSize,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
