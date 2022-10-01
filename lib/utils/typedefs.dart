import "package:flutter/widgets.dart" show BuildContext, Widget;
import "package:scroll_to_index/scroll_to_index.dart" show AutoScrollController;

typedef OnTapListener = void Function();

typedef OnItemChangeListener = void Function(int newIndex);

typedef OnTabChangeListener = OnItemChangeListener;

typedef OnValueListener<T> = void Function(T value);

typedef OnValueChangeListener<T> = OnValueListener<T>;

typedef OnContentItemClickListener = void Function(
  String contentId,
  bool isLocked,
);

typedef OnAnimationListener = void Function();

typedef PlaceholderBuilder = Widget Function(
  BuildContext context,
  String url,
);

typedef ErrorBuilder = Widget Function(
  BuildContext context,
  String url,
  dynamic error,
);

typedef AcsvSliversBuilder = List<Widget> Function(
  AutoScrollController autoScrollController,
);

typedef AppInViewNotifierWidgetBuilder = Widget Function(
  BuildContext context,
  bool isInView,
  Widget child,
);
