import "dart:collection" show UnmodifiableListView;

import "package:flutter/foundation.dart" show ChangeNotifier;

class QuizResultModel extends ChangeNotifier {
  late final List<int> _selectedAnswers;

  QuizResultModel({required int totalQuestions})
      : _selectedAnswers = List<int>.filled(totalQuestions, -1);

  UnmodifiableListView<int> get selectedAnswers =>
      UnmodifiableListView<int>(_selectedAnswers);

  void setSelectedAnswer(int questionIndex, int selectedAnswerIndex) {
    if (questionIndex >= _selectedAnswers.length) {
      throw IndexError(questionIndex, selectedAnswerIndex);
    }

    _selectedAnswers[questionIndex] = selectedAnswerIndex;

    notifyListeners();
  }
}
