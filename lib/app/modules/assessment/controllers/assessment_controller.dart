
// controllers/assessment_controller.dart
import 'package:get/get.dart';

import '../models/assessment_model.dart';


class AssessmentController extends GetxController {
  var assessments = <AssessmentModel>[
    AssessmentModel(
      title: 'Child Autism Diagnosis',
      description: 'Assess early signs of autism in children with age-appropriate screening.',
      questionCount: '10 Questions',
      duration: '3 Minutes',
      bgColor: 0xFFFFF4DC,
    ),
    AssessmentModel(
      title: 'Child Autism Diagnosis',
      description: 'Assess early signs of autism in children with age-appropriate screening.',
      questionCount: '10 Questions',
      duration: '3 Minutes',
      bgColor: 0xFFF2FFDB,
    ),
    // Add more items here...
  ].obs;
}
