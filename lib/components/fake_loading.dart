import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";
import "package:flutter_svg/flutter_svg.dart";

class FakeLoading extends StatelessWidget {
  final Widget child;
  final Widget? loading;
  final int millisToShow;
  final Duration? animationDuration;

  const FakeLoading({
    Key? key,
    required this.child,
    this.loading,
    this.millisToShow = 100, // TODO Move to res file
    this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future<void>.delayed(
        Duration(
          milliseconds: millisToShow,
        ),
      ),
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
          duration: animationDuration ?? Res.animParams.defaultDuration,
          child: widget,
        );
      },
    );
  }
}
