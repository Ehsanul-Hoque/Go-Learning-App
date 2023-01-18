import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:app/pages/quiz/constants/quiz_constants.dart";
import "package:app/pages/quiz/enums/quiz_state.dart";
import "package:app/pages/quiz/models/ques_ans_info.dart";
import "package:app/pages/quiz/models/quiz_info.dart";
import "package:app/utils/extensions/iterable_extension.dart";
import "package:flutter/widgets.dart" show BuildContext, ChangeNotifier;
import "package:provider/provider.dart" show ChangeNotifierProvider;
import "package:provider/single_child_widget.dart";

class QuizNotifier extends ChangeNotifier {
  /// Default constructor
  QuizNotifier({
    required QuizState initialState,
    required ContentTreeGetResponseContents quizContent,
    CourseGetResponse? course,
  })  : _currentState = initialState,
        _quizContent = quizContent,
        _course = course;

  /// Current quiz state
  QuizState _currentState;
  QuizState get currentState => _currentState;
  set currentState(QuizState newState) {
    _currentState = newState;
    notifyListeners();
  }

  /// Quiz content response
  final ContentTreeGetResponseContents _quizContent;
  ContentTreeGetResponseContents get quizContent => _quizContent;

  /// Quiz content response
  final CourseGetResponse? _course;
  CourseGetResponse? get course => _course;

  /// Map to contain quiz info mapped with quiz state
  final Map<QuizState, QuizInfo> _quizStateInfo = <QuizState, QuizInfo>{};

  /// Static method to create simple provider
  /// with previous quiz attempt information
  static SingleChildWidget createProviderWithPrevAttempt({
    required QuizState initialState,
    required ContentTreeGetResponseContents quizContent,
    required QuizAttemptGetResponseData? prevAttemptData,
    CourseGetResponse? course,
  }) {
    return ChangeNotifierProvider<QuizNotifier>(
      create: (BuildContext context) => QuizNotifier(
        initialState: initialState,
        quizContent: quizContent,
        course: course,
      )..prevAttemptData = prevAttemptData,
    );
  }

  /// Method to select/deselect and answer
  void selectDeselectAnswer(String questionId, String ans) {
    QuesAnsInfo? quesAns = currentStateQuizInfo?.quesAns[questionId];

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

  QuizInfo? get prevAttemptInfo => _quizStateInfo[QuizState.previousAttempt];
  QuizInfo? get currentAttemptInfo => _quizStateInfo[QuizState.currentAttempt];

  set prevAttemptData(QuizAttemptGetResponseData? prevAttemptData) =>
      _populateQuizInfo(QuizState.previousAttempt, prevAttemptData);

  set currentAttemptData(QuizAttemptGetResponseData? currentAttemptData) =>
      _populateQuizInfo(QuizState.currentAttempt, currentAttemptData);

  bool get hasPrevAttemptInfo => prevAttemptInfo != null;
  bool get hasCurrentAttemptInfo => currentAttemptInfo != null;

  QuizInfo? get currentStateQuizInfo {
    switch (currentState) {
      case QuizState.previousAttempt:
        return prevAttemptInfo;

      case QuizState.currentAttempt:
        return currentAttemptInfo;

      case QuizState.result:
        return null;
    }
  }

  void _populateQuizInfo(
    QuizState quizState,
    QuizAttemptGetResponseData? attemptData,
  ) {
    QuizInfo quizInfo = QuizInfo();
    List<QuizAttemptGetResponseQuestion?>? questions = attemptData?.questions;
    Map<String, List<String?>?>? submittedAns = attemptData?.submittedAns;

    // Set questions, correct answers, positive and negative marks
    if (questions == null) {
      return;
    }

    for (QuizAttemptGetResponseQuestion? item in questions) {
      if (item == null) continue;

      String? quesId = item.sId;
      if (quesId == null) continue;

      quizInfo.quesAns[quesId] = QuesAnsInfo(
        question: item,
        correctAnswers:
            Set<int>.of(_getAnsIndexListFromStringList(item.allAnswersList)),
        positiveMarks: item.mark,
        negativeMarks: item.negativeMark,
      );
    }

    // Set submitted answers
    if (submittedAns == null) {
      return;
    }

    for (String key in submittedAns.keys) {
      List<String?>? value = submittedAns[key];
      if (value == null) continue;

      QuesAnsInfo? quesAnsInfo = quizInfo.quesAns[key];
      if (quesAnsInfo == null) continue;

      quesAnsInfo.selectedAnswers = Set<int>.of(
        _getAnsIndexListFromStringList(value.getNonNulls().toList()),
      );
    }

    // Set duration, positive, negative and neutral marks
    Duration totalDuration = Duration(
      minutes: attemptData?.durationInMinutes ??
          _quizContent.durationInMinutes ??
          QuizConstants.defaultDurationInMinutes,
    );

    quizInfo.totalDuration = totalDuration;

    QuesAnsInfo? firstQuesAns = quizInfo.quesAns.values.elementAtOrNull(0);
    quizInfo.positiveMarks = firstQuesAns?.positiveMarks;
    quizInfo.negativeMarks = firstQuesAns?.negativeMarks;
    quizInfo.neutralMarks = firstQuesAns?.neutralMarks;

    // Set the quiz info to the quiz state
    _quizStateInfo[quizState] = quizInfo;
  }

  static int _getAnsIndexFromString(String ans) {
    return ans.isEmpty
        ? -1
        : ans[0].toLowerCase().codeUnitAt(0) - "a".codeUnitAt(0);
  }

  static List<int> _getAnsIndexListFromStringList(List<String> answers) =>
      answers.map((String ans) => _getAnsIndexFromString(ans)).toList();
}
