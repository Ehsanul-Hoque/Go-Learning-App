import "package:app/app_config/resources.dart";
import "package:app/components/app_bar/my_app_bar_config.dart";
import "package:app/components/my_circle_avatar.dart";
import "package:app/utils/painters/app_bar_with_avatar_painter.dart";
import "package:app/utils/typedefs.dart" show OnAnimationListener;
import "package:flutter/cupertino.dart";

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
  late final OnAnimationListener _avatarAnimationListener;
  late final Duration _animationDuration;
  late final Curve _animationCurve;
  late final AnimationController _animationController;
  late final Animation<double> _curvedAnimation;
  final Tween<double> _avatarXAnimTween = Tween<double>(),
      _avatarSizeAnimTween = Tween<double>();
  late Animation<double> _avatarXAnimation, _avatarSizeAnimation;
  late double avatarCenterX, avatarRadius;

  @override
  void initState() {
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

    avatarCenterX = 0;
    avatarRadius = 0;

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
    _avatarXAnimTween.end = widget.config.avatarCenterX;

    _avatarSizeAnimTween.begin = avatarRadius;
    _avatarSizeAnimTween.end = widget.config.avatarRadius;
  }

  @override
  void didUpdateWidget(covariant MyAppBar oldWidget) {
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
    return Container(
      height: widget.preferredSize.height + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          Res.shadows.normal,
        ],
      ),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return CustomPaint(
            painter: AppBarWithAvatarPainter(
              color: widget.config.backgroundColor,
              avatarCenterX: avatarCenterX,
              avatarRadius: avatarRadius,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  bottom: -avatarRadius,
                  left: avatarCenterX - avatarRadius,
                  child: MyCircleAvatar(
                    imageUrl:
                        "https://preview.redd.it/gwqupsh46yn51.png?width=301&format=png&auto=webp&s=60efa3b8c4375c7589c929945a840c60c713c949", // TODO Get profile picture from API
                    radius: avatarRadius,
                    padding: 1,
                  ),
                ),
                if (widget.config.endActions.isNotEmpty)
                  Positioned(
                    right: Res.dimen.normalSpacingValue,
                    bottom: 0,
                    child: SizedBox(
                      height: widget.config.toolbarHeight,
                      child: Wrap(
                        // alignment: WrapAlignment.center,
                        // crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: Res.dimen.normalSpacingValue,
                        runSpacing: Res.dimen.xsSpacingValue,
                        children: widget.config.endActions,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
