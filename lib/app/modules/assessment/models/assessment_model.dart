// models/assessment_model.dart
class AssessmentModel {
  final String title;
  final String description;
  final String questionCount;
  final String duration;
  final int bgColor;

  AssessmentModel({
    required this.title,
    required this.description,
    required this.questionCount,
    required this.duration,
    required this.bgColor,
  });
}
