import "package:app/app_config/resources.dart";
import "package:app/components/app_loading_anim.dart";
import "package:flutter/widgets.dart";

class FakeLoading extends StatelessWidget {
  final Widget child;
  final Widget? loading;
  final Duration? loadingDuration;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const FakeLoading({
    Key? key,
    required this.child,
    this.loading,
    this.loadingDuration,
    this.animationDuration,
    this.animationCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration loadingDuration =
        this.loadingDuration ?? Res.durations.fakeLoadingDuration;

    return FutureBuilder<void>(
      future: Future<void>.delayed(loadingDuration),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        Widget widget;

        if (snapshot.connectionState == ConnectionState.waiting) {
          widget = loading ?? const AppLoadingAnim();
          // widget = loading ?? const SizedBox.shrink();
        } else {
          widget = child;
        }

        return AnimatedSwitcher(
          duration: animationDuration ?? Res.durations.defaultDuration,
          switchInCurve: animationCurve ?? Res.curves.defaultCurve,
          switchOutCurve: animationCurve ?? Res.curves.defaultCurve,
          child: widget,
        );
      },
    );
  }
}
