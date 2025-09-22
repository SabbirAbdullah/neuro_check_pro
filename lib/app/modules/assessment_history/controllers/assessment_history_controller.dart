import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/pref_repository.dart';
import '../../../data/repository/profile_repository.dart';
import '../models/answers_history_model.dart';
import '../models/assessment_history_model.dart';

class AssessmentHistoryController extends GetxController{
  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());
  final ProfileRepository _repository =
  Get.find(tag: (ProfileRepository).toString());

  @override
  void onInit() {
    super.onInit();
    loadSubmissions();

  }

  var submissions = <Submission>[].obs;

  Future<void> loadSubmissions() async {
    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');
    try {
      isLoading.value = true;
      final response = await _repository.fetchSubmissions(userId, token);
      submissions.assignAll(response.payload);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  var isLoading = false.obs;
  var answers = <AnswerHistoryModel>[].obs;

  Future<void> loadAnswers(int assessmentId, int patientId) async {
    final token = await _prefRepository.getString('token');
    try {
      isLoading.value = true;
      final data = await _repository.fetchAnswers(assessmentId, patientId, token);
      answers.value = data;
    } finally {
      isLoading.value = false;
    }
  }

}