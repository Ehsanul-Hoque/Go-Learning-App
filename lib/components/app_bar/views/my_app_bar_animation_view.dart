import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/utils/typedefs.dart"
    show MyAppBarWithAvatarBuilder, OnAnimationListener;
import "package:flutter/widgets.dart";

class MyAppBarAnimationView extends StatefulWidget {
  final MyAppBarConfig config;
  final MyAppBarWithAvatarBuilder builder;

  const MyAppBarAnimationView({
    Key? key,
    required this.config,
    required this.builder,
  }) : super(key: key);

  @override
  State<MyAppBarAnimationView> createState() => _MyAppBarAnimationViewState();
}

class _MyAppBarAnimationViewState extends State<MyAppBarAnimationView>
    with SingleTickerProviderStateMixin {
  late OnAnimationListener _avatarAnimationListener;
  late Duration _animationDuration;
  late Curve _animationCurve;
  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;
  final Tween<double> _avatarXAnimTween = Tween<double>(),
      _avatarSizeAnimTween = Tween<double>();
  late Animation<double> _avatarXAnimation, _avatarSizeAnimation;
  late double avatarCenterX, avatarRadius;

  @override
  void initState() {
    assert(widget.config.avatarConfig != null);

    avatarCenterX = 0;
    avatarRadius = 0;

    _avatarAnimationListener = () {
      setState(() {
        avatarCenterX = _avatarXAnimation.value;
        avatarRadius = _avatarSizeAnimation.value;
      });
    };

    _animationDuration = widget.config.animationDuration;
    _animationCurve = widget.config.animationCurve;

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: _animationCurve,
    );

    updateTweenData();

    _avatarXAnimation = _avatarXAnimTween.animate(_curvedAnimation)
      ..addListener(_avatarAnimationListener);
    _avatarSizeAnimation = _avatarSizeAnimTween.animate(_curvedAnimation)
      ..addListener(_avatarAnimationListener);

    _animationController.forward();

    super.initState();
  }

  void updateTweenData() {
    _avatarXAnimTween.begin = avatarCenterX;
    _avatarXAnimTween.end = widget.config.avatarConfig!.avatarCenterX;

    _avatarSizeAnimTween.begin = avatarRadius;
    _avatarSizeAnimTween.end = widget.config.avatarConfig!.avatarRadius;
  }

  @override
  void didUpdateWidget(covariant MyAppBarAnimationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateTweenData();
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _avatarXAnimation.removeListener(_avatarAnimationListener);
    _avatarSizeAnimation.removeListener(_avatarAnimationListener);
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      _animationController,
      avatarCenterX,
      avatarRadius,
    );
  }
}
