import "package:app/network/models/api_contents/quiz_attempt_get_response.dart";

class QuestionAnswerPair {
  QuizAttemptGetResponseQuestion question;
  Set<int> selectedAnswers; // 0-based indices
  Set<int> correctAnswers; // 0-based indices

  QuestionAnswerPair({
    required this.question,
    required this.selectedAnswers,
    required this.correctAnswers,
  });
}
