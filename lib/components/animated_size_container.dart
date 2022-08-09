import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class AnimatedSizeContainer extends StatefulWidget {
  final Duration? animationDuration;
  final Curve? animationCurve;
  final Animation<double>? animation;
  final bool animateForward, animateOnInit;
  final double axisAlignment;
  final Axis axis;
  final Widget child;

  const AnimatedSizeContainer({
    Key? key,
    this.animationDuration,
    this.animationCurve,
    this.animation,
    this.animateForward = true,
    this.animateOnInit = false,
    this.axisAlignment = 0,
    this.axis = Axis.horizontal,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedSizeContainer> createState() => _AnimatedSizeContainerState();
}

class _AnimatedSizeContainerState extends State<AnimatedSizeContainer>
    with SingleTickerProviderStateMixin {
  Duration? animationDuration;
  Curve? animationCurve;
  AnimationController? _animationController;
  Animation<double>? _curvedAnimation;

  @override
  void initState() {
    if (widget.animation == null) {
      animationDuration =
          widget.animationDuration ?? Res.animParams.defaultDuration;
      animationCurve = widget.animationCurve ?? Res.animParams.defaultCurve;

      _animationController = AnimationController(
        vsync: this,
        duration: animationDuration,
      );

      _curvedAnimation = CurvedAnimation(
        parent: _animationController!,
        curve: animationCurve!,
      );

      if (widget.animateOnInit) {
        if (widget.animateForward) {
          _animationController!.forward();
        } else {
          _animationController!.reverse();
        }
      }
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedSizeContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation == null) {
      if (widget.animateForward != oldWidget.animateForward) {
        if (widget.animateForward) {
          _animationController?.forward();
        } else {
          _animationController?.reverse();
        }
      }
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: widget.axisAlignment,
      sizeFactor: widget.animation ?? _curvedAnimation!,
      axis: widget.axis,
      child: widget.child,
    );
  }
}
