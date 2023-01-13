import "dart:collection" show UnmodifiableListView;

import "package:flutter/foundation.dart" show ChangeNotifier;

@Deprecated("Use QuizNotifier instead")
class QuizResultNotifier extends ChangeNotifier {
  late final List<int> _selectedAnswers;
  late final List<int> _correctAnswers;

  late final int _totalQuestions;
  int get totalQuestions => _totalQuestions;

  QuizResultNotifier({
    required List<int> correctAnswers,
  })  : _totalQuestions = correctAnswers.length,
        _selectedAnswers = List<int>.filled(correctAnswers.length, -1),
        _correctAnswers = correctAnswers;

  UnmodifiableListView<int> get selectedAnswers =>
      UnmodifiableListView<int>(_selectedAnswers);

  UnmodifiableListView<int> get correctAnswers =>
      UnmodifiableListView<int>(_correctAnswers);

  void setSelectedAnswer(int questionIndex, int selectedAnswerIndex) {
    if (questionIndex >= totalQuestions) {
      throw IndexError(questionIndex, selectedAnswerIndex);
    }

    _selectedAnswers[questionIndex] = selectedAnswerIndex;

    notifyListeners();
  }
}
