import "package:app/app_config/resources.dart";
import "package:app/utils/typedefs.dart" show AppInViewNotifierWidgetBuilder;
import "package:flutter/widgets.dart";
import "package:inview_notifier_list/inview_notifier_list.dart";
import "package:scroll_to_index/scroll_to_index.dart";

class AcsvSliverToBoxAdapter extends StatelessWidget {
  final Widget child;

  /// Set the two variables below null to disable InViewNotifierWidget.
  final String? inViewNotifierId;
  final AppInViewNotifierWidgetBuilder? appInViewNotifierWidgetBuilder;

  // Set the three variables below null to disable AutoScrollTag.
  final Key? autoScrollTagKey;
  final AutoScrollController? autoScrollController;
  final int? autoScrollTagIndex;
  final Color? autoScrollTagHighlightColor;

  final double borderRadius;

  const AcsvSliverToBoxAdapter({
    Key? key,
    required this.child,
    this.inViewNotifierId,
    this.appInViewNotifierWidgetBuilder,
    this.autoScrollTagKey,
    this.autoScrollController,
    this.autoScrollTagIndex,
    this.autoScrollTagHighlightColor,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Builder(
        builder: (BuildContext context) {
          Widget resultWidget = child;

          if ((autoScrollTagKey != null) &&
              (autoScrollController != null) &&
              (autoScrollTagIndex != null)) {
            resultWidget = AutoScrollTag(
              key: autoScrollTagKey!,
              controller: autoScrollController!,
              index: autoScrollTagIndex!,
              highlightColor: autoScrollTagHighlightColor ??
                  Res.color.acsvAutoScrollHighlight,
              child: resultWidget,
            );
          }

          if (inViewNotifierId != null &&
              appInViewNotifierWidgetBuilder != null) {
            resultWidget = InViewNotifierWidget(
              id: inViewNotifierId!,
              builder: (BuildContext context, bool isInView, Widget? child) {
                return appInViewNotifierWidgetBuilder!(
                  context,
                  isInView,
                  child!,
                );
              },
              child: resultWidget,
            );
          }

          if (borderRadius > 0) {
            resultWidget = ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: resultWidget,
            );
          }

          return resultWidget;
        },
      ),
    );
  }
}
