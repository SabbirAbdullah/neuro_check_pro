
// controllers/assessment_controller.dart
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/repository/assessment_repository.dart';
import 'package:neuro_check_pro/app/modules/assessment/widgets/assessment_payment_page.dart';

import '../../../data/model/answer_submission_model.dart';
import '../../../data/repository/patient_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../patient_profile/models/patient_profile_model.dart';
import '../models/answer_model.dart';
import '../models/assessment_model.dart';
import '../models/child_model.dart';
import '../models/patient_info.dart';
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
      final response = await _repository.getAssessments(id,token,"premium");
      assessments.assignAll(response.payload);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  var patient = Rxn<Patient>();

  /// Returns true if the patient has the assessment
  Future<bool> checkAssessmentForUI(int patientId, int targetAssessmentId) async {
    final token = await _prefRepository.getString('token');
    try {
      isLoading.value = true;
      final response = await _repository.fetchPatient(patientId, token);

      if (response.payload.isNotEmpty) {
        patient.value = response.payload.first;

        // Check if target assessment exists
        return patient.value!.assessments.any((a) => a.assessmentId == targetAssessmentId);
      }
      return false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  var checkoutUrl = ''.obs;

  Future<void> startCheckout(String priceId, int assessmentId, int patientId) async {
    final token = await _prefRepository.getString('token');
    try {
      isLoading.value = true;
      final response = await _repository.getCheckoutUrl(priceId, assessmentId, patientId, token);
      checkoutUrl.value = response.url;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  var questions = <QuestionModel>[].obs;
  var currentIndex = 0.obs;
// Can hold either single string OR multiple strings
  var answers = <int, dynamic>{}.obs;
 // {questionId: "Yes"/"No"}


  Future<void> loadQuestions(int assessmentId) async {
    isLoading.value = true;
    final token = await _prefRepository.getString('token');
    questions.value = await _repository.getQuestionsByAssessment(assessmentId, token);
    currentIndex.value = 0; // always start from first
    answers.clear();
    isLoading.value = false;
  }

  void selectAnswer(dynamic answer) {
    if (questions.isEmpty || currentIndex.value >= questions.length) {
      return; // safeguard against out of range/null
    }

    final q = questions[currentIndex.value];
    final questionId = q.id;
    final answerType = q.answerType;

    if (questionId == null) return; // safeguard

    if (answerType == "MultipleChoice") {
      final current = (answers[questionId] ?? <String>[]).cast<String>();
      if (current.contains(answer)) {
        current.remove(answer); // unselect
      } else {
        current.add(answer); // select
      }
      answers[questionId] = current;
    } else {
      // For Yes/No or Text
      answers[questionId] = answer;
    }

    // refresh only the relevant widget (safe null-aware id)
    update(["textField_$questionId"]);
  }





  void goToNextQuestion(int patientId) { if (currentIndex.value < questions.length - 1) { currentIndex.value++; } else {
    // Finished -> go to summary page
    Get.to(() => QuestionSummary(controller: this,patientId: patientId,));
  } }

  void goToPreviousQuestion() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }



  Future<void> submitAllAnswers( int patientId) async {
    isLoading.value = true;
    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');
    final assessmentId = 27;

    final answersList = questions.map((q) {
      final ans = answers[q.id] ?? "";
      return AnswerSubmission(
        questionId: q.id,
        userId: userId,
        patientId: patientId,
        assessmentId: assessmentId,
        answer: ans,
      );
    }).toList();

    final request = SubmissionRequest(
      patientId: patientId,
      assessmentId: assessmentId,
      userId: userId,
      score: 0,
      summary: "",
      answers: answersList,
    );

    try {
      final response = await _repository.submitAnswers(request, token);
      Get.snackbar("Success", "All answers submitted!");
      Get.offAll(() =>  SubmitSuccessPage());
    } catch (e) {
      Get.snackbar("Error", "Submission failed: $e");
    }finally{
      isLoading.value = false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    loadAssessments();

  }


}

