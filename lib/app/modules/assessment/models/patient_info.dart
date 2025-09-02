// patient_model.dart
class PatientResponse {
  final String message;
  final int statusCode;
  final List<Patient> payload;

  PatientResponse({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory PatientResponse.fromJson(Map<String, dynamic> json) {
    return PatientResponse(
      message: json["message"],
      statusCode: json["statusCode"],
      payload: (json["payload"] as List)
          .map((e) => Patient.fromJson(e))
          .toList(),
    );
  }
}

class Patient {
  final int id;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String relationshipToUser;
  final List<Assessment> assessments;

  Patient({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.relationshipToUser,
    required this.assessments,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json["id"],
      name: json["name"],
      dateOfBirth: json["dateOfBirth"],
      gender: json["gender"],
      relationshipToUser: json["relationshipToUser"],
      assessments: (json["assessments"] as List)
          .map((e) => Assessment.fromJson(e))
          .toList(),
    );
  }
}

class Assessment {
  final int id;
  final int patientId;
  final int assessmentId;
  final int userId;
  final int score;
  final String summary;

  Assessment({
    required this.id,
    required this.patientId,
    required this.assessmentId,
    required this.userId,
    required this.score,
    required this.summary,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) {
    return Assessment(
      id: json["id"],
      patientId: json["patientId"],
      assessmentId: json["assessmentId"],
      userId: json["userId"],
      score: json["score"] ?? 0,
      summary: json["summary"] ?? "",
    );
  }
}
