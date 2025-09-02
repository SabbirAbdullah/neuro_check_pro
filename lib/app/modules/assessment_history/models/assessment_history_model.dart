// submission_model.dart

class AssessmentHistoryModel {
  final String message;
  final int statusCode;
  final List<Submission> payload;

  AssessmentHistoryModel({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory AssessmentHistoryModel.fromJson(Map<String, dynamic> json) {
    return AssessmentHistoryModel(
      message: json["message"],
      statusCode: json["statusCode"],
      payload: (json["payload"] as List)
          .map((e) => Submission.fromJson(e))
          .toList(),
    );
  }
}

class Submission {
  final int id;
  final int patientId;
  final int assessmentId;
  final int userId;
  final int score;
  final String status;
  final String ratings;
  final String additionalInfo;
  final String summary;
  final DateTime createdAt;
  final PatientHistory patient;
  final AssessmentHistory assessment;
  final UserHistory user;

  Submission({
    required this.id,
    required this.patientId,
    required this.assessmentId,
    required this.userId,
    required this.score,
    required this.status,
    required this.ratings,
    required this.additionalInfo,
    required this.summary,
    required this.createdAt,
    required this.patient,
    required this.assessment,
    required this.user,
  });

  factory Submission.fromJson(Map<String, dynamic> json) {
    return Submission(
      id: json["id"],
      patientId: json["patientId"],
      assessmentId: json["assessmentId"],
      userId: json["userId"],
      score: json["score"] ?? 0,
      summary: json["summary"] ?? "",
      status: json["status"] ?? "",
      ratings: json["summary"] ?? "",
      additionalInfo: json["additionalInfo"] ?? "",
      createdAt: DateTime.parse(json["createdAt"]),
      patient: PatientHistory.fromJson(json["patient"]),
      assessment: AssessmentHistory.fromJson(json["assessment"]),
      user: UserHistory.fromJson(json["user"]),
    );
  }
}

class PatientHistory {
  final int id;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String relationshipToUser;

  PatientHistory({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.relationshipToUser,
  });

  factory PatientHistory.fromJson(Map<String, dynamic> json) {
    return PatientHistory(
      id: json["id"],
      name: json["name"],
      dateOfBirth: json["dateOfBirth"],
      gender: json["gender"],
      relationshipToUser: json["relationshipToUser"],
    );
  }
}

class AssessmentHistory {
  final int id;
  final String name;
  final String description;
  final String type;
  final String totalTime;
  final String category;
  final String priceId;

  AssessmentHistory({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.totalTime,
    required this.category,
    required this.priceId,
  });

  factory AssessmentHistory.fromJson(Map<String, dynamic> json) {
    return AssessmentHistory(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      type: json["type"],
      totalTime: json["totalTime"],
      category: json["category"],
      priceId: json["priceId"],
    );
  }
}

class UserHistory {
  final int id;
  final String name;
  final String email;
  final String phone;

  UserHistory({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserHistory.fromJson(Map<String, dynamic> json) {
    return UserHistory(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
    );
  }
}
