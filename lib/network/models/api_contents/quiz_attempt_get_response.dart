import "package:app/network/models/api_model.dart";
import "package:json_annotation/json_annotation.dart";

part "../../../generated/api_contents/quiz_attempt_get_response.g.dart";

@JsonSerializable()
class QuizAttemptGetResponse extends ApiModel {
  @JsonKey(name: "success")
  final String? success;

  /// If there is no quiz attempt before, value of this field will be false.
  /// But if there has been at least a quiz attempt before,
  /// this variable will contain a [QuizAttemptGetResponseData] type.
  @JsonKey(name: "data")
  @QuizAttemptGetResponseDataConverter()
  final QuizAttemptGetResponseData? data;

  QuizAttemptGetResponse({
    this.success,
    this.data,
  });

  factory QuizAttemptGetResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptGetResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuizAttemptGetResponseToJson(this);
}

@JsonSerializable()
class QuizAttemptGetResponseData extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "content_type")
  final String? contentType;

  @JsonKey(name: "questions")
  final List<QuizAttemptGetResponseQuestion?>? questions;

  @JsonKey(name: "submitted_ans")
  final Map<String, List<String?>?>? submittedAns;

  @JsonKey(name: "submitted")
  final bool? submitted;

  @JsonKey(name: "quiz_id")
  final String? quizId;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "duration")
  final int? durationInMinutes;

  @JsonKey(name: "description")
  final String? description;

  @JsonKey(name: "student_id")
  final String? studentId;

  @JsonKey(name: "total_score")
  final double? totalScore;

  @JsonKey(name: "__v")
  final int? iV;

  const QuizAttemptGetResponseData({
    this.sId,
    this.contentType,
    this.questions,
    this.submittedAns,
    this.submitted,
    this.quizId,
    this.title,
    this.durationInMinutes,
    this.description,
    this.studentId,
    this.totalScore,
    this.iV,
  });

  factory QuizAttemptGetResponseData.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptGetResponseDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuizAttemptGetResponseDataToJson(this);
}

@JsonSerializable()
class QuizAttemptGetResponseQuestion extends ApiModel {
  @JsonKey(name: "_id")
  final String? sId;

  @JsonKey(name: "right_ans")
  final List<String?>? rightAns;

  @JsonKey(name: "mark")
  final double? mark;

  @JsonKey(name: "negative_mark")
  final double? negativeMark;

  @JsonKey(name: "identifier_title")
  final String? identifierTitle;

  @JsonKey(name: "subject")
  final String? subject;

  @JsonKey(name: "chapter")
  final String? chapter;

  @JsonKey(name: "topic")
  final String? topic;

  @JsonKey(name: "title")
  final String? title;

  @JsonKey(name: "a")
  final String? a;

  @JsonKey(name: "b")
  final String? b;

  @JsonKey(name: "c")
  final String? c;

  @JsonKey(name: "d")
  final String? d;

  /// This indicates if the user has answered this question correctly or not
  @JsonKey(name: "status")
  final bool? status;

  @JsonKey(name: "__v")
  final int? iV;

  const QuizAttemptGetResponseQuestion({
    this.sId,
    this.rightAns,
    this.mark,
    this.negativeMark,
    this.identifierTitle,
    this.subject,
    this.chapter,
    this.topic,
    this.title,
    this.a,
    this.b,
    this.c,
    this.d,
    this.status,
    this.iV,
  });

  factory QuizAttemptGetResponseQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptGetResponseQuestionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuizAttemptGetResponseQuestionToJson(this);
}

class QuizAttemptGetResponseDataConverter
    implements JsonConverter<QuizAttemptGetResponseData?, Object?> {
  const QuizAttemptGetResponseDataConverter();

  @override
  QuizAttemptGetResponseData? fromJson(Object? jsonField) =>
      (jsonField == null) || (jsonField is bool)
          ? null
          : QuizAttemptGetResponseData.fromJson(
              jsonField as Map<String, dynamic>,
            );

  @override
  Object? toJson(QuizAttemptGetResponseData? object) =>
      (object?.toJson()) ?? false;
}
