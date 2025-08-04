import 'package:get/get.dart';
import '../models/diagnosis_model.dart';


class DiagnosisController extends GetxController {
  final assessments = <AssessmentProgressModel>[
    AssessmentProgressModel(
      name: 'Oliver Bernett',
      assessment: 'Child Autism Diagnosis',
      date: '25th July, 2025',
      status: 'Completed',
      totalQuestions: 40,
      answeredQuestions: 40,
    ),
    AssessmentProgressModel(
      name: 'Oliver Bernett',
      assessment: 'Child Autism Diagnosis',
      date: '25th July, 2025',
      status: 'Pending',
      totalQuestions: 40,
      answeredQuestions: 18,
    ),
  ].obs;
}
