import "package:app/utils/app_colors.dart";
import "package:app/app_config/default_parameters.dart";
import "package:flutter/widgets.dart";

class AppBottomNavigationItem extends StatefulWidget {
  final double? width;
  final double? height;
  final double spaceBetweenIconAndText;
  final Function()? onTap;
  final Widget icon;
  final String text;
  final double iconSize, textSize;
  final Axis axis;
  final bool isSelected;
  final Color activeColor, inactiveColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const AppBottomNavigationItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.activeColor,
    required this.inactiveColor,
    this.width,
    this.height,
    this.iconSize = 24,
    this.textSize = 14,
    this.axis = Axis.horizontal,
    this.spaceBetweenIconAndText = 4,
    this.isSelected = false,
    this.onTap,
    this.animationDuration = DefaultParameters.defaultAnimationDuration,
    this.animationCurve = DefaultParameters.defaultAnimationCurve,
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
  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    );

    _colorAnimation = ColorTween(
      begin: widget.inactiveColor,
      end: widget.activeColor,
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
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        width: widget.width,
        height: widget.height,
        // color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1),
        color: AppColors.transparent,
        child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (BuildContext context, Widget? child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                _colorAnimation.value ?? widget.inactiveColor,
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
                width: widget.iconSize,
                height: widget.iconSize,
                child: widget.icon,
              ),
              SizeTransition(
                axisAlignment: 1,
                sizeFactor: _curvedAnimation,
                axis: widget.axis,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: (widget.axis == Axis.horizontal)
                          ? widget.spaceBetweenIconAndText
                          : 0,
                      top: (widget.axis == Axis.vertical)
                          ? widget.spaceBetweenIconAndText
                          : 0,
                    ),
                    child: Text(
                      widget.text,
                      style: DefaultParameters.defaultTextStyle.copyWith(
                        fontSize: widget.textSize,
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
