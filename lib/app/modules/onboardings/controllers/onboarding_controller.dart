// controllers/onboarding_controller.dart
import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get.dart';
import '../../../data/local/preference/preference_manager.dart';
import '../../../data/model/user_info_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../bottom_navigation/views/bottom_navigation_view.dart';
 // adjust path accordingly

class OnboardingController extends GetxController {

  var currentPage = 0.obs;

  void nextPage() {
    if (currentPage.value < 3) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void skipToLast() {
    currentPage.value = 3;
  }



}
