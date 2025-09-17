import '../../assessment/models/assessment_model.dart';

class DraftModel {
  final int patientId;
  final String patientName;
  final int assessmentId;
  final String assessmentName;
  final int totalQuestions;
  final String draftBody;

  DraftModel({
    required this.patientId,
    required this.patientName,
    required this.assessmentId,
    required this.assessmentName,
    required this.totalQuestions,
    required this.draftBody,
  });
}

// class DraftModel {
//   final AssessmentModel assessment;
//   final int currentIndex;
//   final Map<int, dynamic> answers;
//
//   DraftModel({
//     required this.assessment,
//     required this.currentIndex,
//     required this.answers,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "assessment": {
//       "id": assessment.id,
//       "name": assessment.name,
//       "description": assessment.description,
//       "createdAt": assessment.createdAt,
//       "type": assessment.type,
//       "totalTime": assessment.totalTime,
//       "category": assessment.category,
//       "priceId": assessment.priceId,
//       "questionnaire": assessment.questionnaire != null
//           ? {
//         "id": assessment.questionnaire!.id,
//         "assessmentId": assessment.questionnaire!.assessmentId,
//         "questions": assessment.questionnaire!.questions,
//         "createdAt": assessment.questionnaire!.createdAt,
//         "order": assessment.questionnaire!.order,
//         "options": assessment.questionnaire!.options,
//         "answerType": assessment.questionnaire!.answerType,
//       }
//           : null,
//       "stripeInfo": assessment.stripeInfo != null
//           ? {
//         "productId": assessment.stripeInfo!.productId,
//         "name": assessment.stripeInfo!.name,
//         "description": assessment.stripeInfo!.description,
//         "currency": assessment.stripeInfo!.currency,
//         "unit_amount": assessment.stripeInfo!.unitAmount,
//       }
//           : null,
//     },
//     "currentIndex": currentIndex,
//     "answers": answers.map((k, v) => MapEntry(k.toString(), v)),
//   };
//
//   factory DraftModel.fromJson(Map<String, dynamic> json) {
//     return DraftModel(
//       assessment: AssessmentModel.fromJson(json["assessment"]),
//       currentIndex: json["currentIndex"] ?? 0,
//       answers: (json["answers"] as Map<String, dynamic>)
//           .map((k, v) => MapEntry(int.parse(k), v)),
//     );
//   }
// }
