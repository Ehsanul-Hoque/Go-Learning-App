import "package:app/app_config/resources.dart";
import "package:app/components/advanced_custom_scroll_view/notifiers/acsv_scroll_notifier.dart";
import "package:app/utils/typedefs.dart" show AcsvSliversBuilder;
import "package:flutter/widgets.dart";
import "package:inview_notifier_list/inview_notifier_list.dart";
import "package:provider/provider.dart";
import "package:scroll_to_index/scroll_to_index.dart";

class AdvancedCustomScrollView extends StatefulWidget {
  final AcsvSliversBuilder acsvSliversBuilder;
  final Axis axis;
  final IsInViewPortCondition? isInViewPortCondition;

  // Id to consume the scroll events using Consumer.
  // Set the value to null to disable Consumer.
  final String? scrollNotifierId;

  const AdvancedCustomScrollView({
    Key? key,
    required this.acsvSliversBuilder,
    this.axis = Axis.vertical,
    this.isInViewPortCondition,
    this.scrollNotifierId,
  }) : super(key: key);

  @override
  State<AdvancedCustomScrollView> createState() =>
      _AdvancedCustomScrollViewState();
}

class _AdvancedCustomScrollViewState extends State<AdvancedCustomScrollView> {
  late AutoScrollController _autoScrollController;
  int currentlyVisibleIndex = 0;

  @override
  void initState() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: widget.axis,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> slivers = widget.acsvSliversBuilder(_autoScrollController);
    InViewNotifierCustomScrollView sv = InViewNotifierCustomScrollView(
      isInViewPortCondition: widget.isInViewPortCondition ??
          (double deltaTop, double deltaBottom, double vpHeight) {
            // return deltaTop <= 0 && deltaBottom >= 10;
            return deltaTop < (Res.dimen.inViewTopLimitFraction * vpHeight) &&
                deltaBottom < (Res.dimen.inViewBottomLimitFraction * vpHeight);
          },
      controller: _autoScrollController,
      scrollDirection: widget.axis,
      slivers: slivers,
    );

    if (widget.scrollNotifierId != null) {
      return Consumer<AcsvScrollNotifier?>(
        builder: (
          BuildContext context,
          AcsvScrollNotifier? scroll,
          Widget? child,
        ) {
          if (scroll == null) {
            return child!;
          }

          if ((scroll.notifierId == widget.scrollNotifierId) &&
              (scroll.currentVisibleIndex != currentlyVisibleIndex)) {
            currentlyVisibleIndex = scroll.currentVisibleIndex;

            if (scroll.updateScrollView) {
              _scrollToIndex(scroll.currentVisibleIndex);
            }
          }

          return child!;
        },
        child: sv,
      );
    } else {
      return sv;
    }
  }

  Future<void> _scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
    _autoScrollController.highlight(index);
  }
}
