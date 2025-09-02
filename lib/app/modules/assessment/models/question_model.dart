class QuestionModel {
  final int id;
  final int assessmentId;
  final String questions;
  final DateTime createdAt;
  final int order;
  final List<String> ?options;
  final String answerType;
  bool isSubmitted; //

  QuestionModel({
    required this.id,
    required this.assessmentId,
    required this.questions,
    required this.createdAt,
    required this.order,
     this.options,
    required this.answerType,
    this.isSubmitted = false,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      assessmentId: json['assessmentId'],
      questions: json['questions'],
      createdAt: DateTime.parse(json['createdAt']),
      order: json['order'],
      options: (json['options'] as List<dynamic>).map((e) => e.toString()).toList() ?? [],
      answerType: json['answerType'],
    );
  }
}


class QuestionResponseModel {
  final String message;
  final int statusCode;
  final List<QuestionModel> payload;

  QuestionResponseModel({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) {
    return QuestionResponseModel(
      message: json['message'],
      statusCode: json['statusCode'],
      payload: (json['payload'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }
}
