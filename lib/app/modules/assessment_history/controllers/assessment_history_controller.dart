import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repository/pref_repository.dart';
import '../../../data/repository/profile_repository.dart';
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
  var isLoading = false.obs;
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
  final assessments = [
    {
      'title': 'Initial Assessment',
      'date': '20 July, 2025',
      'status': 'Completed',
      'statusColor': Color(0xff32B355),
      'bgColor': const Color(0xFFF5F1FF),
      'buttonText': 'View details',
    },
    {
      'title': 'Child Autism Diagnosis',
      'date': '20 July, 2025',
      'status': 'Reviewing',
      'statusColor': Colors.yellow.shade700,
      'bgColor': const Color(0xFFE3F3FF),
      'buttonText': 'View details',
    },
    {
      'title': 'Child Autism Diagnosis',
      'date': '20 July, 2025',
      'status': 'Pending',
      'statusColor': Colors.yellow.shade300,
      'bgColor': const Color(0xFFE6F4FD),
      'buttonText': 'Continue',
    },
  ];
}