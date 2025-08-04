class AssessmentProgressModel {
  final String name;
  final String assessment;
  final String date;
  final String status; // "Completed" or "Pending"
  final int totalQuestions;
  final int answeredQuestions;

  AssessmentProgressModel({
    required this.name,
    required this.assessment,
    required this.date,
    required this.status,
    required this.totalQuestions,
    required this.answeredQuestions,
  });

  int get remainingQuestions => totalQuestions - answeredQuestions;
  double get progress => answeredQuestions / totalQuestions;
}
