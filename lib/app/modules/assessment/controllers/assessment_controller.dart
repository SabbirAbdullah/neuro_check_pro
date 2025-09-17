
// controllers/assessment_controller.dart
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/repository/assessment_repository.dart';
import 'package:neuro_check_pro/app/modules/assessment/widgets/assessment_payment_page.dart';

import '../../../data/model/answer_submission_model.dart';
import '../../../data/repository/patient_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../patient_profile/models/patient_profile_model.dart';
import '../../primary_assessment/views/primary_assessment.dart';
import '../models/answer_model.dart';
import '../models/assessment_model.dart';
import '../models/child_model.dart';
import '../models/patient_info.dart';
import '../models/question_model.dart';
import '../widgets/question_page.dart';
import '../widgets/queston_submit_page.dart';


class AssessmentController extends GetxController {
  final AssessmentRepository _repository =
  Get.find(tag: (AssessmentRepository).toString());

  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());

  var assessments = <AssessmentModel>[].obs;
  var isLoading = false.obs;
  var isDeleting = false.obs;
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

  var questions = <QuestionModel>[].obs;
  var currentIndex = 0.obs;
  var answers = <int, dynamic>{}.obs;
  var isNavigating = false.obs;

  static String draftKey( int assessmentId, int patientId,) => "draft_${assessmentId }_$patientId";

  Future<void> loadQuestions(int assessmentId, int patientId) async {
    isLoading.value = true;
    final token = await _prefRepository.getString('token');

    // Load fresh questions
    questions.value = await _repository.getQuestionsByAssessment(assessmentId, token);

    // Try restoring draft
    await restoreDraft(assessmentId, patientId);

    isLoading.value = false;
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


  Future<void> submitAllAnswers( int patientId, int assessmentId) async {
    isLoading.value = true;
    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');


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
      // score: 0,
      summary: "",
      answers: answersList,
    );

    try {
      final response = await _repository.submitAnswers(request, token);
      Get.snackbar("Success", "All answers submitted!");
       clearDraft(assessmentId, patientId);
      Get.offAll(() =>  SubmitSuccessPage());

    } catch (e) {
      Get.snackbar("Error", "Submission failed: $e");
    }finally{
      isLoading.value = false;
    }
  }

  void selectAnswer(dynamic answer, int patientId, String assessmentName) {
    if (questions.isEmpty || currentIndex.value >= questions.length) return;

    final q = questions[currentIndex.value];
    final questionId = q.id;

    if (q.answerType == "MultipleChoice") {
      final current = (answers[questionId] ?? <String>[]).cast<String>();
      if (current.contains(answer)) {
        current.remove(answer);
      } else {
        current.add(answer);
      }
      answers[questionId] = current;
    } else {
      answers[questionId] = answer;
    }

    // Save draft on every change
    saveDraft(q.assessmentId, patientId, assessmentName);

    update(["textField_$questionId"]);
  }

  void goToNextQuestion(int patientId, int assessmentId, String assessmentName) {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
      saveDraft(assessmentId,  patientId, assessmentName);
    } else {
      // Finished -> clear draft & go summary
      clearDraft(assessmentId,  patientId);
      Get.to(() => PaidQuestionSummary(
        controller: this,
        assessmentId: assessmentId,
        patientId: patientId,
      ));
    }
  }

  void goToPreviousQuestion(int assessmentId, int patientId, String assessmentName ) {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      saveDraft(assessmentId,  patientId, assessmentName);
    }
  }

  Future<void> saveDraft(int assessmentId, int patientId, String assessmentName) async {
    final draft = {
      "currentIndex": currentIndex.value,
      "answers": answers.map((key, value) => MapEntry(key.toString(), value)),
      "assessmentName": assessments.firstWhere(
            (a) => a.id == assessmentId,
        orElse: () => AssessmentModel(id: assessmentId, name: assessmentName, description: '', createdAt: '', type: ''),
      ).name,
      "patientName": patient.value?.name ?? "Unknown",
      "questionLength": questions.length,
    };

    await _prefRepository.setString(
      draftKey( assessmentId, patientId),
      jsonEncode(draft),
    );
  }


  Future<void> restoreDraft(int assessmentId, int patientId) async {
    final draftString = await _prefRepository.getString(draftKey(assessmentId, patientId));
    if (draftString != null && draftString.isNotEmpty) {
      final draft = jsonDecode(draftString);
      currentIndex.value = draft["currentIndex"] ?? 0;
      final storedAnswers = draft["answers"] as Map<String, dynamic>? ?? {};
      answers.value = storedAnswers.map((key, value) => MapEntry(int.parse(key), value));

      // You can also restore optional info if needed
      final assessmentName = draft["assessmentName"] ?? "";
      final patientName = draft["patientName"] ?? "";
      final totalQuestions = draft["questionLength"] ?? 0;

      debugPrint("Restored draft: $assessmentName - $patientName ($totalQuestions questions)");
    }
  }

  Future<void> clearDraft( int assessmentId ,int patientId,) async {
    await _prefRepository.remove(draftKey(assessmentId,patientId));
  }
  Future<List<Map<String, dynamic>>> getAllDrafts() async {
    final keys = await _prefRepository.getKeys();

    // Convert each key into a Future<Map<String, dynamic>?>
    final drafts = await Future.wait(keys
        .where((k) => k.startsWith("draft_"))
        .map((k) async {
      final draftString = await _prefRepository.getString(k);
      if (draftString == null || draftString.isEmpty) return null;

      final draft = jsonDecode(draftString);
      final parts = k.split("_");

      return {
        "assessmentId": int.parse(parts[1]),
        "patientId": int.parse(parts[2]),
        "assessmentName": draft["assessmentName"] ?? "",
        "patientName": draft["patientName"] ?? "",
        "questionLength": draft["questionLength"] ?? 0,
        "currentIndex": draft["currentIndex"] ?? 0,
      };
    })
        .toList());

    // remove nulls
    return drafts.whereType<Map<String, dynamic>>().toList();
  }



  @override
  void onInit() {
    super.onInit();
    loadAssessments();

  }


}

