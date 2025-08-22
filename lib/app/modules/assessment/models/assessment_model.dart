class AssessmentModel {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String type;
  final String? totalTime;
  final String? category;

  AssessmentModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.type,
    this.totalTime,
    this.category,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? "",
      createdAt: json['createdAt'] ?? "",
      type: json['type']??"",
      totalTime: json['totalTime'] ??"",
      category: json['category']??"",
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
      message: json['message'],
      statusCode: json['statusCode'],
      payload: list,
    );
  }
}
