class AnswerModel {
  final int questionId;
  final int userId;
  final int patientId;
  final int assessmentId;
  final dynamic answer; // String or List<String>

  AnswerModel({
    required this.questionId,
    required this.userId,
    required this.patientId,
    required this.assessmentId,
    required this.answer,
  });

  Map<String, dynamic> toJson() {
    return {
      "questionId": questionId,
      "userId": userId,
      "patientId": patientId,
      "assessmentId": assessmentId,
      "answer": answer is List ? answer.join(", ") : answer.toString(),
    };
  }
}
