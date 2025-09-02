class AssessmentModel {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String type;
  final String? totalTime;
  final String? category;
  final String? priceId;
  final QuestionnaireModel? questionnaire;
  final StripeInfoModel? stripeInfo;

  AssessmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.type,
    this.priceId,
    this.totalTime,
    this.category,
    this.questionnaire,
    this.stripeInfo,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'],
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      createdAt: json['createdAt'] ?? "",
      type: json['type'] ?? "",
      totalTime: json['totalTime']??"",
      category: json['category'],
      priceId: json['priceId'],
      questionnaire: json['questionnaire'] != null
          ? QuestionnaireModel.fromJson(json['questionnaire'])
          : null,
      stripeInfo: json['stripeInfo'] != null
          ? StripeInfoModel.fromJson(json['stripeInfo'])
          : null,
    );
  }
}
class QuestionnaireModel {
  final int id;
  final int assessmentId;
  final List<String> questions;   // <-- changed to List<String>
  final String createdAt;
  final int order;
  final List<String>? options;    // <-- changed to List<String>?
  final String answerType;

  QuestionnaireModel({
    required this.id,
    required this.assessmentId,
    required this.questions,
    required this.createdAt,
    required this.order,
    this.options,
    required this.answerType,
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json['id'],
      assessmentId: json['assessmentId'],
      questions: (json['questions'] is List)
          ? List<String>.from(json['questions'])
          : (json['questions'] != null ? (json['questions'] as String).split(";") : []),
      createdAt: json['createdAt'] ?? "",
      order: json['order'] ?? 0,
      options: (json['options'] is List)
          ? List<String>.from(json['options'])
          : null,
      answerType: json['answerType'] ?? "",
    );
  }
}

class StripeInfoModel {
  final String productId;
  final String name;
  final String? description;
  final String currency;
  final int  ? unitAmount;

  StripeInfoModel({
    required this.productId,
    required this.name,
    this.description,
    required this.currency,
     this.unitAmount,
  });

  factory StripeInfoModel.fromJson(Map<String, dynamic> json) {
    return StripeInfoModel(
      productId: json['productId'],
      name: json['name'] ?? "",
      description: json['description'],
      currency: json['currency'] ?? "",
      unitAmount: json['unit_amount'] ?? 0,
    );
  }
}

class AssessmentResponseModel {
  final String message;
  final int statusCode;
  final List<AssessmentModel> payload;

  AssessmentResponseModel({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory AssessmentResponseModel.fromJson(Map<String, dynamic> json) {
    final list = (json['payload'] as List)
        .map((e) => AssessmentModel.fromJson(e))
        .toList();
    return AssessmentResponseModel(
      message: json['message'] ?? "",
      statusCode: json['statusCode'] ?? 0,
      payload: list,
    );
  }
}
