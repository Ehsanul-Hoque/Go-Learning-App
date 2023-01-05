import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:flutter/widgets.dart"
    show AnimationController, BuildContext, Widget;
import "package:scroll_to_index/scroll_to_index.dart" show AutoScrollController;

typedef OnTapListener = void Function();

typedef OnTapListener3<T1, T2, T3> = void Function(T1, T2, T3);

typedef OnItemChangeListener = void Function(int newIndex);

typedef OnTabChangeListener = OnItemChangeListener;

typedef OnValueListener<T> = void Function(T value);

typedef OnValueChangeListener<T> = OnValueListener<T>;

typedef OnContentItemClickListener = void Function(
  ContentTreeGetResponseContents content,
);

typedef OnAnimationListener = void Function();

typedef OnErrorListener<T> = OnValueListener<T>;

typedef IndexedItemBuilder = Widget Function(BuildContext context, int index);

typedef PlaceholderBuilder = Widget Function(
  BuildContext context,
  String url,
);

typedef ErrorBuilder = Widget Function(
  BuildContext context,
  String url,
  dynamic error,
);

typedef MyAppBarWithAvatarBuilder = Widget Function(
  AnimationController animationController,
  double avatarCenterX,
  double avatarRadius,
);

typedef AcsvSliversBuilder = List<Widget> Function(
  AutoScrollController autoScrollController,
);

typedef AppInViewNotifierWidgetBuilder = Widget Function(
  BuildContext context,
  bool isInView,
  Widget child,
);

typedef VideoPlayerChildBuilder = Widget Function(
  BuildContext context,
  Widget player,
);

typedef ContentWorkerCreator<T> = ContentWorker<T> Function(
  CourseGetResponse? courseItem,
  ContentTreeGetResponseContents contentItem,
);
