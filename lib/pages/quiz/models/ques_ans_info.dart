import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";

class QuesAnsInfo {
  QuesAnsInfo({
    required this.question,
    required this.correctAnswers,
    this.selectedAnswers = const <int>{},
    this.positiveMarks,
    this.negativeMarks,
    this.neutralMarks,
  });

  QuizAttemptGetResponseQuestion question;
  Set<int> correctAnswers; // 0-based indices
  Set<int> selectedAnswers; // 0-based indices
  double? positiveMarks;
  double? negativeMarks;
  double? neutralMarks;
}
