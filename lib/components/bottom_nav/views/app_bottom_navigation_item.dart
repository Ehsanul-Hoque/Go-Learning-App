import "package:app/app_config/resources.dart";
import "package:app/components/animated_size_container.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/widgets.dart";

class AppBottomNavigationItem extends StatefulWidget {
  final double? width, height;
  final double? spaceBetweenIconAndText;
  final OnTapListener onTap;
  final Widget icon;
  final String text;
  final double? iconSize, textSize;
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
    this.iconSize,
    this.textSize,
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
  late Color backgroundColor, activeColor, inactiveColor;

  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    animationDuration =
        widget.animationDuration ?? Res.animParams.defaultDuration;
    animationCurve = widget.animationCurve ?? Res.animParams.defaultCurve;

    iconSize = widget.iconSize ?? Res.dimen.iconSizeNormal;
    textSize = widget.textSize ?? Res.dimen.fontSizeNormal;
    spaceBetweenIconAndText =
        widget.spaceBetweenIconAndText ?? Res.dimen.extraSmallSpacingValue;
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
        // color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
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
              SizedBox(
                width: iconSize,
                height: iconSize,
                child: widget.icon,
              ),
              AnimatedSizeContainer(
                animateForward: widget.isSelected,
                animateOnInit: true,
                axisAlignment: 1,
                axis: widget.axis,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: (widget.axis == Axis.horizontal)
                          ? spaceBetweenIconAndText
                          : 0,
                      top: (widget.axis == Axis.vertical)
                          ? spaceBetweenIconAndText
                          : 0,
                    ),
                    child: Text(
                      widget.text,
                      style: Res.textStyles.general.copyWith(
                        fontSize: textSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
