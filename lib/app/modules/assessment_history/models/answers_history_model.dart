class QuestionHistory {
  final int id;
  final String questions;
  final List<String> options;
  final String answerType;

  QuestionHistory({
    required this.id,
    required this.questions,
    required this.options,
    required this.answerType,
  });

  factory QuestionHistory.fromJson(Map<String, dynamic> json) {
    return QuestionHistory(
      id: json['id'],
      questions: json['questions'],
      options: (json['options'] as List<dynamic>).map((e) => e.toString()).toList(),
      answerType: json['answerType'],
    );
  }
}

class AnswerHistoryModel {
  final int id;
  final int questionId;
  final String answer;
  final int userId;
  final int patientId;
  final int assessmentId;
  final QuestionHistory question;

  AnswerHistoryModel({
    required this.id,
    required this.questionId,
    required this.answer,
    required this.userId,
    required this.patientId,
    required this.assessmentId,
    required this.question,
  });

  factory AnswerHistoryModel.fromJson(Map<String, dynamic> json) {
    return AnswerHistoryModel(
      id: json['id'],
      questionId: json['questionId'],
      answer: json['answer'],
      userId: json['userId'],
      patientId: json['patientId'],
      assessmentId: json['assessmentId'],
      question: QuestionHistory.fromJson(json['question']),
    );
  }
}

class AnswerHistoryResponse {
  final String message;
  final int statusCode;
  final List<AnswerHistoryModel> payload;

  AnswerHistoryResponse({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory AnswerHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AnswerHistoryResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      payload: (json['payload'] as List)
          .map((e) => AnswerHistoryModel.fromJson(e))
          .toList(),
    );
  }
}
