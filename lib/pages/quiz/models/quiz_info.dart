import "package:app/pages/quiz/constants/quiz_constants.dart";
import "package:app/pages/quiz/models/ques_ans_info.dart";

class QuizInfo {
  // Fields
  Duration? totalDuration;
  Map<String, QuesAnsInfo>? _quesAns;
  double? _positiveMarks;
  double? _negativeMarks;
  double? _neutralMarks;

  // Getters
  Map<String, QuesAnsInfo> get quesAns => _quesAns ?? <String, QuesAnsInfo>{};
  double get positiveMarks =>
      _positiveMarks ?? QuizConstants.defaultPositiveMarksPerAns;
  double get negativeMarks =>
      _negativeMarks ?? QuizConstants.defaultNegativeMarksPerAns;
  double get neutralMarks =>
      _neutralMarks ?? QuizConstants.defaultMarksPerBlankAns;

  // Setters
  set quesAns(Map<String, QuesAnsInfo>? quesAns) => _quesAns = quesAns;
  set positiveMarks(double? positiveMarks) => _positiveMarks = positiveMarks;
  set negativeMarks(double? negativeMarks) => _negativeMarks = negativeMarks;
  set neutralMarks(double? neutralMarks) => _neutralMarks = neutralMarks;
}
