class PatientModel {
  final int id;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String relationshipToUser;
  final String aboutGp;
  final String profileTag;
  final int userId;

  PatientModel({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.relationshipToUser,
    required this.aboutGp,
    required this.profileTag,
    required this.userId,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      relationshipToUser: json['relationshipToUser'],
      aboutGp: json['aboutGp'],
      profileTag: json['profileTag'],
      userId: json['userId'],
    );
  }
}

class AssessmentModel {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String type;
  final String totalTime;
  final String category;
  final String priceId;

  AssessmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.type,
    required this.totalTime,
    required this.category,
    required this.priceId,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['createdAt'],
      type: json['type'],
      totalTime: json['totalTime'],
      category: json['category'],
      priceId: json['priceId'],
    );
  }
}

class BillingInfoModel {
  final int id;
  final String priceId;
  final String sessionId;
  final String customerEmail;
  final String amount;
  final String currency;
  final String paymentStatus;
  final int? patientId;
  final int? assessmentId;
  final String createdAt;
  final PatientModel? patient;
  final AssessmentModel? assessment;

  BillingInfoModel({
    required this.id,
    required this.priceId,
    required this.sessionId,
    required this.customerEmail,
    required this.amount,
    required this.currency,
    required this.paymentStatus,
    this.patientId,
    this.assessmentId,
    required this.createdAt,
    this.patient,
    this.assessment,
  });

  factory BillingInfoModel.fromJson(Map<String, dynamic> json) {
    return BillingInfoModel(
      id: json['id'],
      priceId: json['priceId'],
      sessionId: json['sessionId'],
      customerEmail: json['customerEmail'],
      amount: json['amount'],
      currency: json['currency'],
      paymentStatus: json['paymentStatus'],
      patientId: json['patientId'],
      assessmentId: json['assessmentId'],
      createdAt: json['createdAt'],
      patient: json['patient'] != null ? PatientModel.fromJson(json['patient']) : null,
      assessment: json['assessment'] != null ? AssessmentModel.fromJson(json['assessment']) : null,
    );
  }
}
