import "package:flutter/widgets.dart" show BuildContext, ChangeNotifier;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart";

class AcsvScrollNotifier extends ChangeNotifier {
  String? _notifierId;
  int _currentVisibleIndex = 0;
  bool _updateScrollView = false;

  String? get notifierId => _notifierId;
  int get currentVisibleIndex => _currentVisibleIndex;
  bool get updateScrollView => _updateScrollView;

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<AcsvScrollNotifier>(
        create: (BuildContext context) => AcsvScrollNotifier(),
      );

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
