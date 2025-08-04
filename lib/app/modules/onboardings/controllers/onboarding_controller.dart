// controllers/onboarding_controller.dart
import 'package:get/get.dart';

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

  void getStarted() {
    // Navigate to your home/login screen
    Get.offAllNamed('/home'); // Replace with your actual route
  }
}
