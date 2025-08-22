
// controllers/assessment_controller.dart
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/repository/assessment_repository.dart';
import 'package:neuro_check_pro/app/modules/assessment/widgets/assessment_payment_page.dart';

import '../../../data/repository/patient_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../models/assessment_model.dart';
import '../models/child_model.dart';
import '../models/question_model.dart';
import '../widgets/question_page.dart';


class AssessmentController extends GetxController {
  final AssessmentRepository _repository =
  Get.find(tag: (AssessmentRepository).toString());

  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());

  var assessments = <AssessmentModel>[].obs;
  var isLoading = false.obs;

  Future<void> loadAssessments() async {
    final token = await _prefRepository.getString('token');
    final id = await _prefRepository.getInt('id');

    try {
      isLoading.value = true;
      final response = await _repository.getAssessments(id,token);
      assessments.assignAll(response.payload);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  var questions = <QuestionModel>[].obs;
  var currentIndex = 0.obs;
  var answers = <int, String>{}.obs; // {questionId: "Yes"/"No"}



  Future<void> loadQuestions(int assessmentId) async {
    isLoading.value = true;
    final token = await _prefRepository.getString('token');
    questions.value = await _repository.getQuestionsByAssessment(assessmentId, token);
    currentIndex.value = 0; // always start from first
    answers.clear();
    isLoading.value = false;
  }

  void selectAnswer(String answer) {
    final questionId = questions[currentIndex.value].id;
    answers[questionId] = answer;
  }

  void goToNextQuestion() {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    } else {
      // Finished -> go to summary page
      Get.to(() => QuestionSummary(controller: this));
    }
  }

  void goToPreviousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }
  @override
  void onInit() {
    super.onInit();
    loadAssessments();

  }


}

