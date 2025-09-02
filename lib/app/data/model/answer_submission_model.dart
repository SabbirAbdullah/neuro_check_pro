class AnswerSubmission {
  final int questionId;
  final int userId;
  final int patientId;
  final int assessmentId;
  final dynamic answer;
  // can be String or List<String>

  AnswerSubmission({
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

class SubmissionRequest {
  final int patientId;
  final int assessmentId;
  final int userId;
  final int score;
  final String summary;
  final List<AnswerSubmission> answers;

  SubmissionRequest({
    required this.patientId,
    required this.assessmentId,
    required this.userId,
    required this.score,
    required this.summary,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      "patientId": patientId,
      "assessmentId": assessmentId,
      "userId": userId,
      "score": score,
      "summary": summary,
      "answers": answers.map((a) => a.toJson()).toList(),
    };
  }
}

class SubmissionResponse {
  final int id;
  final int patientId;
  final int assessmentId;
  final int userId;
  final int score;
  final String summary;
  final DateTime createdAt;

  SubmissionResponse({
    required this.id,
    required this.patientId,
    required this.assessmentId,
    required this.userId,
    required this.score,
    required this.summary,
    required this.createdAt,
  });

  factory SubmissionResponse.fromJson(Map<String, dynamic> json) {
    return SubmissionResponse(
      id: json['id'],
      patientId: json['patientId'],
      assessmentId: json['assessmentId'],
      userId: json['userId'],
      score: json['score'],
      summary: json['summary'] ?? "",
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
