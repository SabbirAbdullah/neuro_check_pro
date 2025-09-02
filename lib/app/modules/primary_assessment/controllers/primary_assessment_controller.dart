import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/primary_assessment/models/child_profile_model.dart';
import 'package:neuro_check_pro/app/modules/primary_assessment/widgets/add_child.dart';

import '../../../data/model/answer_submission_model.dart';
import '../../../data/repository/assessment_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../assessment/models/assessment_model.dart';
import '../../assessment/models/question_model.dart';
import '../views/primary_assessment.dart';
import '../widgets/child_profile.dart';
import '../widgets/quiz_results.dart';



class PrimaryAssessmentController extends GetxController {

  final AssessmentRepository _repository =
  Get.find(tag: (AssessmentRepository).toString());
  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());

  var questions = <QuestionModel>[].obs;
  var answers = <int, dynamic>{}.obs; // {questionId: "Yes"/"No"/"Text"/["A","B"]}
  var currentIndex = 0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initialAssessment();
  }
  var assessments = <AssessmentModel>[].obs;
  Future<void> initialAssessment() async {
    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');

    try {
      isLoading.value = true;
      final response =
      await _repository.getAssessments(userId, token, "free");
      assessments.assignAll(response.payload);
      if (response.payload.isNotEmpty) {
        await loadQuestions(response.payload[0].id);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadQuestions(int assessmentId) async {
    isLoading.value = true;
    final token = await _prefRepository.getString('token');
    questions.value =
    await _repository.getQuestionsByAssessment(assessmentId, token);
    currentIndex.value = 0;
    answers.clear();
    isLoading.value = false;
  }

  /// ✅ Save selected answer
  void selectAnswer(dynamic answer) {
    if (questions.isEmpty || currentIndex.value >= questions.length) return;
    final q = questions[currentIndex.value];
    final questionId = q.id;
    final answerType = q.answerType;

    if (questionId == null) return;

    if (answerType == "MultipleChoice") {
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

    update(["textField_$questionId"]);
  }

  void goToNextQuestion(int patientId) {
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    } else {
      Get.to(() =>
          QuestionSummary(controller: this, patientId: patientId));
    }
  }

  void goToPreviousQuestion() {
    if (currentIndex.value > 0) currentIndex.value--;
  }
  var submission = <SubmissionResponse>[].obs;
  /// ✅ Submission payload
  Future<void> submitAllAnswers(int patientId) async {
    isLoading.value = true;
    try {

      final token = await _prefRepository.getString('token');
      final userId = await _prefRepository.getInt('id');
      final int assessmentId = assessments[0].id; // replace with actual ID

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

      final response= await _repository.submitAnswers(request, token!);

      Get.offAll(() => PrimaryQuizResultView(response: response,question: questions.length));
    } catch (e) {
      Get.snackbar("Error", "Submission failed: $e");
    }
    finally{
      isLoading.value = false;
    }
  }



  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final gpController = TextEditingController();
  final tagController = TextEditingController();

  RxString gender = ''.obs;
  RxString relationship = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (_) {
        return Column(
          children: [
            Container(
              color: Colors.grey.shade200,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Next", style: TextStyle(color: Colors.blue)),
                ),
              ),
            ),
            Expanded(

              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,backgroundColor: Colors.white,
                initialDateTime: selectedDate.value ?? DateTime.now(),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (date) {
                  selectedDate.value = date;
                  dobController.text =
                  "${date.day} ${_monthName(date.month)} ${date.year}";
                },
              ),
            ),

          ],
        );

      },
    );
  }


  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

}
