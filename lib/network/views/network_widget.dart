import "package:app/app_config/resources.dart";
import "package:app/components/app_loading_anim.dart";
import "package:app/components/status_text.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:flutter/widgets.dart";
import "package:sliver_tools/sliver_tools.dart";

typedef SelectFunction = NetworkCallStatus Function();
typedef NoContentFunction = bool Function();
typedef SuccessChildBuilder = Widget Function(BuildContext context);

class NetworkWidget extends StatelessWidget {
  final SelectFunction callStatusSelector;
  final SuccessChildBuilder childBuilder;
  final Widget? statusNoneWidget,
      statusNoInternetWidget,
      statusLoadingWidget,
      statusFailedWidget,
      noContentWidget;
  final String? statusNoneText,
      statusNoInternetText,
      statusFailedText,
      noContentText;
  final NoContentFunction? noContentChecker;
  final bool shouldOutputBeSliver;

  const NetworkWidget({
    Key? key,
    required this.callStatusSelector,
    required this.childBuilder,
    this.statusNoneWidget,
    this.statusNoInternetWidget,
    this.statusLoadingWidget,
    this.statusFailedWidget,
    this.noContentWidget,
    this.statusNoneText,
    this.statusNoInternetText,
    this.statusFailedText,
    this.noContentText,
    this.noContentChecker,
    this.shouldOutputBeSliver = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        NetworkCallStatus callStatus = callStatusSelector();
        Widget? widget;

        switch (callStatus) {
          case NetworkCallStatus.none:
            widget = statusNoneWidget ??
                StatusText(statusNoneText ?? Res.str.startNetworkCall);
            break;

          case NetworkCallStatus.noInternet:
            widget = statusNoInternetWidget ??
                StatusText(statusNoInternetText ?? Res.str.noInternet);
            break;

          case NetworkCallStatus.loading:
            widget = statusLoadingWidget ?? const AppLoadingAnim();
            break;

          case NetworkCallStatus.failed:
            widget = statusFailedWidget ??
                StatusText(statusFailedText ?? Res.str.generalError);
            break;

          default:
            break;
        }

        if (noContentChecker != null) {
          if ((widget == null) && noContentChecker!()) {
            widget = noContentWidget ??
                StatusText(noContentText ?? Res.str.noContents);
          }
        }

        if ((widget != null) && shouldOutputBeSliver) {
          widget = SliverToBoxAdapter(
            child: widget,
          );
        }

        widget ??= childBuilder(context);

        return AnimatedSwitcher(
          duration: Res.durations.longDuration,
          switchInCurve: Res.curves.defaultCurve,
          switchOutCurve: Res.curves.defaultCurve,
          transitionBuilder: shouldOutputBeSliver
              ? SliverAnimatedSwitcher.defaultTransitionBuilder
              : AnimatedSwitcher.defaultTransitionBuilder,
          layoutBuilder: shouldOutputBeSliver
              ? SliverAnimatedSwitcher.defaultLayoutBuilder
              : AnimatedSwitcher.defaultLayoutBuilder,
          child: widget,
        );
      },
    );
  }
}
