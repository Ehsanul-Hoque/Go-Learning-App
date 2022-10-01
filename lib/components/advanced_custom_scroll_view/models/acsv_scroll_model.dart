import "package:flutter/foundation.dart" show ChangeNotifier;

class AcsvScrollModel extends ChangeNotifier {
  String? _notifierId;
  int _currentVisibleIndex = 0;
  bool _updateScrollView = false;

  String? get notifierId => _notifierId;
  int get currentVisibleIndex => _currentVisibleIndex;
  bool get updateScrollView => _updateScrollView;

  void updateCurrentVisibleIndex({
    required String notifierId,
    required int currentVisibleIndex,
    bool updateScrollView = false,
  }) {
    _notifierId = notifierId;
    _currentVisibleIndex = currentVisibleIndex;
    _updateScrollView = updateScrollView;
    notifyListeners();
  }
}
