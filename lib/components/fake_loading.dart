import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";
import "package:flutter_svg/flutter_svg.dart";

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
          widget = loading ??
              Center(
                child: SizedBox(
                  width: Res.dimen.pageLoadingSize,
                  height: Res.dimen.pageLoadingSize,
                  child: SvgPicture.asset(Res.assets.loadingSvg),
                ),
              );
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
