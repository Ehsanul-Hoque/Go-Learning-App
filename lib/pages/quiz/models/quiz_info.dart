import "package:app/pages/quiz/constants/quiz_constants.dart";
import "package:app/pages/quiz/models/ques_ans_info.dart";

class QuizInfo {
  QuizInfo({
    this.quesAns = const <String, QuesAnsInfo>{},
    this.totalDuration,
    double? positiveMarks,
    double? negativeMarks,
    double? neutralMarks,
  })  : _positiveMarks = positiveMarks,
        _negativeMarks = negativeMarks,
        _neutralMarks = neutralMarks;

  final Map<String, QuesAnsInfo> quesAns;
  Duration? totalDuration;
  double? _positiveMarks;
  double? _negativeMarks;
  double? _neutralMarks;

  double get positiveMarks =>
      _positiveMarks ?? QuizConstants.defaultPositiveMarksPerAns;
  double get negativeMarks =>
      _negativeMarks ?? QuizConstants.defaultNegativeMarksPerAns;
  double get neutralMarks =>
      _neutralMarks ?? QuizConstants.defaultMarksPerBlankAns;

  set positiveMarks(double? positiveMarks) => _positiveMarks = positiveMarks;
  set negativeMarks(double? negativeMarks) => _negativeMarks = negativeMarks;
  set neutralMarks(double? neutralMarks) => _neutralMarks = neutralMarks;
}
