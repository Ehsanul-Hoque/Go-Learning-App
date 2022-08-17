typedef OnTapListener = void Function();

typedef OnItemChangeListener = void Function(int newIndex);

typedef OnTabChangeListener = OnItemChangeListener;

typedef OnValueChangeListener<T> = void Function(T value);

typedef OnAnimationListener = void Function();
