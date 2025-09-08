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
  // final int score;
  final String summary;
  final List<AnswerSubmission> answers;

  SubmissionRequest({
    required this.patientId,
    required this.assessmentId,
    required this.userId,
    // required this.score,
    required this.summary,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return {
      "patientId": patientId,
      "assessmentId": assessmentId,
      "userId": userId,
      // "score": score,
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
  final int? score; // nullable
  final String? summary; // text block seems like summary/description
  final String status;
  final int ratings;
  final String? additionalInfo;
  final String? paidAmount; // API sends as string ("300000")
  final int? clinicianId; // nullable
  final DateTime createdAt;

  SubmissionResponse({
    required this.id,
    required this.patientId,
    required this.assessmentId,
    required this.userId,
    this.score,
    this.summary,
    required this.status,
    required this.ratings,
    this.additionalInfo,
    this.paidAmount,
    this.clinicianId,
    required this.createdAt,
  });

  factory SubmissionResponse.fromJson(Map<String, dynamic> json) {
    return SubmissionResponse(
      id: json['id'] ?? 0,
      patientId: json['patientId'] ?? 0,
      assessmentId: json['assessmentId'] ?? 0,
      userId: json['userId'] ?? 0,
      score: json['score']??0,
      summary: json['summary'], // may come as long text
      status: json['status'] ?? "",
      ratings: json['ratings'] ?? 0,
      additionalInfo: json['additionalInfo'],
      paidAmount: json['paidAmount'],
      clinicianId: json['clinicianId']??0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "patientId": patientId,
      "assessmentId": assessmentId,
      "userId": userId,
      "score": score,
      "summary": summary,
      "status": status,
      "ratings": ratings,
      "additionalInfo": additionalInfo,
      "paidAmount": paidAmount,
      "clinicianId": clinicianId,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
