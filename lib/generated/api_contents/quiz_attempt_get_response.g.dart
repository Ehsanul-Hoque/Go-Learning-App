// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../network/models/api_contents/quiz_attempt_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttemptGetResponse _$QuizAttemptGetResponseFromJson(
        Map<String, dynamic> json) =>
    QuizAttemptGetResponse(
      success: json['success'] as String?,
      data: const QuizAttemptGetResponseDataConverter().fromJson(json['data']),
    );

Map<String, dynamic> _$QuizAttemptGetResponseToJson(
        QuizAttemptGetResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': const QuizAttemptGetResponseDataConverter().toJson(instance.data),
    };

QuizAttemptGetResponseData _$QuizAttemptGetResponseDataFromJson(
        Map<String, dynamic> json) =>
    QuizAttemptGetResponseData(
      sId: json['_id'] as String?,
      contentType: json['content_type'] as String?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : QuizAttemptGetResponseQuestion.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      submittedAns: (json['submitted_ans'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k, (e as List<dynamic>?)?.map((e) => e as String?).toList()),
      ),
      submitted: json['submitted'] as bool?,
      quizId: json['quiz_id'] as String?,
      title: json['title'] as String?,
      durationInMinutes: json['duration'] as int?,
      description: json['description'] as String?,
      studentId: json['student_id'] as String?,
      totalScore: (json['total_score'] as num?)?.toDouble(),
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$QuizAttemptGetResponseDataToJson(
        QuizAttemptGetResponseData instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'content_type': instance.contentType,
      'questions': instance.questions?.map((e) => e?.toJson()).toList(),
      'submitted_ans': instance.submittedAns,
      'submitted': instance.submitted,
      'quiz_id': instance.quizId,
      'title': instance.title,
      'duration': instance.durationInMinutes,
      'description': instance.description,
      'student_id': instance.studentId,
      'total_score': instance.totalScore,
      '__v': instance.iV,
    };

QuizAttemptGetResponseQuestion _$QuizAttemptGetResponseQuestionFromJson(
        Map<String, dynamic> json) =>
    QuizAttemptGetResponseQuestion(
      sId: json['_id'] as String?,
      rightAns: (json['right_ans'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      mark: (json['mark'] as num?)?.toDouble(),
      negativeMark: (json['negative_mark'] as num?)?.toDouble(),
      identifierTitle: json['identifier_title'] as String?,
      subject: json['subject'] as String?,
      chapter: json['chapter'] as String?,
      topic: json['topic'] as String?,
      title: json['title'] as String?,
      a: json['a'] as String?,
      b: json['b'] as String?,
      c: json['c'] as String?,
      d: json['d'] as String?,
      e: json['e'] as String?,
      f: json['f'] as String?,
      g: json['g'] as String?,
      h: json['h'] as String?,
      i: json['i'] as String?,
      j: json['j'] as String?,
      status: json['status'] as bool?,
      iV: json['__v'] as int?,
    );

Map<String, dynamic> _$QuizAttemptGetResponseQuestionToJson(
        QuizAttemptGetResponseQuestion instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'right_ans': instance.rightAns,
      'mark': instance.mark,
      'negative_mark': instance.negativeMark,
      'identifier_title': instance.identifierTitle,
      'subject': instance.subject,
      'chapter': instance.chapter,
      'topic': instance.topic,
      'title': instance.title,
      'a': instance.a,
      'b': instance.b,
      'c': instance.c,
      'd': instance.d,
      'e': instance.e,
      'f': instance.f,
      'g': instance.g,
      'h': instance.h,
      'i': instance.i,
      'j': instance.j,
      'status': instance.status,
      '__v': instance.iV,
    };
