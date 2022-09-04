import "package:flutter/widgets.dart" show BuildContext, Widget;

typedef OnTapListener = void Function();

typedef OnItemChangeListener = void Function(int newIndex);

typedef OnTabChangeListener = OnItemChangeListener;

typedef OnValueChangeListener<T> = void Function(T value);

typedef OnVideoItemClickListener = void Function(String videoId, bool isLocked);

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
