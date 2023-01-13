import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart" show BuildContext, ChangeNotifier;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart";

class QuestionAnswerPair {
  QuizAttemptGetResponseQuestion question;
  Set<int> selectedAnswers; // 0-based
  Set<int> correctAnswers; // 0-based

  QuestionAnswerPair({
    required this.question,
    required this.selectedAnswers,
    required this.correctAnswers,
  });
}

class QuizNotifier extends ChangeNotifier {
  final Map<String, QuestionAnswerPair> prevAttemptQuesAns;
  final Map<String, QuestionAnswerPair> currentAttemptQuesAns;
  // int questionCount;

  QuizNotifier(/*{required this.questionCount}*/)
      : prevAttemptQuesAns = <String, QuestionAnswerPair>{},
        currentAttemptQuesAns = <String, QuestionAnswerPair>{};

  /// Static method to create simple provider
  static SingleChildWidget createProvider() =>
      ChangeNotifierProvider<QuizNotifier>(
        create: (BuildContext context) => QuizNotifier(),
      );

  /// Static method to create simple provider
  /// with previous quiz attempt information
  static SingleChildWidget createProviderWithPrevAttempt(
    List<QuizAttemptGetResponseQuestion?>? questions,
    Map<String, List<String?>?>? submittedAns,
  ) {
    QuizNotifier quizNotifier = QuizNotifier();
    quizNotifier.setPrevAttempt(questions, submittedAns);

    return ChangeNotifierProvider<QuizNotifier>(
      create: (BuildContext context) => quizNotifier,
    );
  }

  /// Method to set previous quiz attempt info
  void setPrevAttempt(
    List<QuizAttemptGetResponseQuestion?>? questions,
    Map<String, List<String?>?>? submittedAns,
  ) =>
      _setAttempt(() => prevAttemptQuesAns, questions, submittedAns);

  /// Method to set current quiz attempt info
  void setCurrentAttempt(
    List<QuizAttemptGetResponseQuestion?>? questions,
    Map<String, List<String?>?>? submittedAns,
  ) =>
      _setAttempt(() => currentAttemptQuesAns, questions, submittedAns);

  /// Method to select/deselect and answer
  void selectDeselectAnswer(String questionId, String ans) {
    QuestionAnswerPair? quesAns = currentAttemptQuesAns[questionId];
    if (ans.isNotEmpty && quesAns != null) {
      int ansIndex = _getAnsIndexFromString(ans);
      Set<int> selectedAnswers = quesAns.selectedAnswers;

      if (selectedAnswers.contains(ansIndex)) {
        selectedAnswers.remove(ansIndex);
      } else {
        selectedAnswers.add(ansIndex);
      }

      notifyListeners();
    }
  }

  int _getAnsIndexFromString(String ans) {
    return ans.isEmpty
        ? -1
        : ans[0].toLowerCase().codeUnitAt(0) - "a".codeUnitAt(0);
  }

  List<int> _getAnsIndexListFromStringList(List<String> answers) =>
      answers.map((String ans) => _getAnsIndexFromString(ans)).toList();

  void _setAttempt(
    Map<String, QuestionAnswerPair> Function() mapGetter,
    List<QuizAttemptGetResponseQuestion?>? questions,
    Map<String, List<String?>?>? submittedAns,
  ) {
    Map<String, QuestionAnswerPair> attemptMap = mapGetter();
    attemptMap.clear();

    if (questions == null) {
      return;
    }

    for (QuizAttemptGetResponseQuestion? item in questions) {
      if (item == null) continue;

      String? quesId = item.sId;
      if (quesId == null) continue;

      attemptMap[quesId] = QuestionAnswerPair(
        question: item,
        selectedAnswers: <int>{},
        correctAnswers:
            Set<int>.of(_getAnsIndexListFromStringList(item.allAnswersList)),
      );
    }

    if (submittedAns == null) {
      return;
    }

    for (String key in submittedAns.keys) {
      List<String?>? value = submittedAns[key];
      if (value == null) continue;

      QuestionAnswerPair? quesAnsPair = attemptMap[key];
      if (quesAnsPair == null) continue;

      quesAnsPair.selectedAnswers = Set<int>.of(
        _getAnsIndexListFromStringList(value.getNonNulls().toList()),
      );
    }
  }
}
