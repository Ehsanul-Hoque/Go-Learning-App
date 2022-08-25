import "package:app/app_config/resources.dart";
import "package:app/app_config/sample_data.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/my_circle_avatar.dart";
import "package:app/utils/painters/app_bar_with_avatar_painter.dart";
import "package:app/utils/typedefs.dart" show OnAnimationListener;
import "package:flutter/cupertino.dart";

part "package:app/components/app_bar/my_app_bar_contents.dart";

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final MyAppBarConfig config;

  const MyAppBar({
    Key? key,
    required this.config,
  }) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(config.toolbarHeight);
}

class _MyAppBarState extends State<MyAppBar>
    with SingleTickerProviderStateMixin {
  OnAnimationListener? _avatarAnimationListener;
  Duration? _animationDuration;
  Curve? _animationCurve;
  AnimationController? _animationController;
  Animation<double>? _curvedAnimation;
  final Tween<double> _avatarXAnimTween = Tween<double>(),
      _avatarSizeAnimTween = Tween<double>();
  Animation<double>? _avatarXAnimation, _avatarSizeAnimation;
  late double avatarCenterX, avatarRadius;

  @override
  void initState() {
    avatarCenterX = 0;
    avatarRadius = 0;

    if (widget.config.avatarConfig != null) {
      _avatarAnimationListener = () {
        setState(() {
          avatarCenterX = _avatarXAnimation?.value ?? 0;
          avatarRadius = _avatarSizeAnimation?.value ?? 0;
        });
      };

      _animationDuration = widget.config.animationDuration;
      _animationCurve = widget.config.animationCurve;

      _animationController = AnimationController(
        vsync: this,
        duration: _animationDuration,
      );

      _curvedAnimation = CurvedAnimation(
        parent: _animationController!,
        curve: _animationCurve!,
      );

      updateTweenData();

      _avatarXAnimation = _avatarXAnimTween.animate(_curvedAnimation!)
        ..addListener(_avatarAnimationListener!);
      _avatarSizeAnimation = _avatarSizeAnimTween.animate(_curvedAnimation!)
        ..addListener(_avatarAnimationListener!);

      _animationController?.forward();
    }

    super.initState();
  }

  void updateTweenData() {
    _avatarXAnimTween.begin = avatarCenterX;
    _avatarXAnimTween.end =
        widget.config.avatarConfig?.avatarCenterX ?? _avatarXAnimTween.begin;

    _avatarSizeAnimTween.begin = avatarRadius;
    _avatarSizeAnimTween.end =
        widget.config.avatarConfig?.avatarRadius ?? _avatarSizeAnimTween.begin;
  }

  @override
  void didUpdateWidget(covariant MyAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.config.avatarConfig != null) {
      updateTweenData();
      _animationController?.reset();
      _animationController?.forward();
    }
  }

  @override
  void dispose() {
    if (widget.config.avatarConfig != null) {
      _avatarXAnimation?.removeListener(_avatarAnimationListener!);
      _avatarSizeAnimation?.removeListener(_avatarAnimationListener!);
      _animationController?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AnimationController? animationController = _animationController;

    return Container(
      height: widget.preferredSize.height + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          Res.shadows.normal,
        ],
      ),
      child: animationController != null
          ? AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                return MyAppBarContents(
                  config: widget.config,
                  avatarCenterX: avatarCenterX,
                  avatarRadius: avatarRadius,
                );
              },
            )
          : MyAppBarContents(
              config: widget.config,
              avatarCenterX: avatarCenterX,
              avatarRadius: avatarRadius,
            ),
    );
  }
}
