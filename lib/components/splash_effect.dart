import "package:app/app_config/resources.dart";
import "package:app/utils/typedefs.dart" show OnTapListener;
import "package:flutter/material.dart" show InkWell, Material;
import "package:flutter/widgets.dart";

class SplashEffect extends StatelessWidget {
  final OnTapListener onTap;
  final Widget child;

  const SplashEffect({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned.fill(
          child: Material(
            color: Res.color.transparent,
            animationDuration: Res.durations.defaultDuration,
            child: InkWell(
              onTap: onTap,
              highlightColor: Res.color.splash,
              splashColor: Res.color.splash,
              child: Container(
                color: Res.color.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
