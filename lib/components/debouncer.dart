import "package:app/app_config/resources.dart";
import "package:app/components/app_loading_anim.dart";
import "package:flutter/widgets.dart";

class Debouncer extends StatelessWidget {
  final Widget child;
  final Widget? loading;
  final Duration? debounceDuration;
  final Duration? transitionDuration;
  final Curve? transitionCurve;

  const Debouncer({
    Key? key,
    required this.child,
    this.loading,
    this.debounceDuration,
    this.transitionDuration,
    this.transitionCurve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration debounceDuration =
        this.debounceDuration ?? Res.durations.debounceDuration;

    return FutureBuilder<void>(
      future: Future<void>.delayed(debounceDuration),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        Widget widget;

        if (snapshot.connectionState == ConnectionState.waiting) {
          widget = loading ?? const AppLoadingAnim();
          // widget = loading ?? const SizedBox.shrink();
        } else {
          widget = child;
        }

        return AnimatedSwitcher(
          duration: transitionDuration ?? Res.durations.defaultDuration,
          switchInCurve: transitionCurve ?? Res.curves.defaultCurve,
          switchOutCurve: transitionCurve ?? Res.curves.defaultCurve,
          child: widget,
        );
      },
    );
  }
}
