import 'dart:async';

import 'package:get/get.dart';

import '../../../data/model/user_info_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';

class SplashController extends GetxController {
  var currentPage = 0.obs;
  final PrefRepository _prefRepo = Get.find(tag: (PrefRepository).toString());
  final AuthenticationRepository _repository =
  Get.find(tag: (AuthenticationRepository).toString());

  var user = Rxn<UserInfoModel>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 2), () {
      checkLoginStatus();
    });

  }

  Future<void> checkLoginStatus() async {
    final token = await _prefRepo.getString('token');
    final id = await _prefRepo.getInt('id');

    if (token.isNotEmpty && id != null) {
      // logged in
      final success = await fetchUserInfo();
      if (success) {
        Get.offNamed('/bottom_navigation_view');
      } else {
        await _prefRepo.clear();
        Get.offAllNamed('/signin_view');
      }
    } else {
      // not logged in
      final onboardingShown = await _prefRepo.isOnboardingShown();
      if (!onboardingShown) {
        Get.offAllNamed('/onboarding_view');
      } else {
        Get.offAllNamed('/signin_view');
      }
    }
  }

  Future<bool> fetchUserInfo() async {
    final token = await _prefRepo.getString('token');
    final id = await _prefRepo.getInt('id');
    if (token.isEmpty || id == null) return false;

    try {
      isLoading.value = true;
      final response = await _repository.getUserById(id, token);

      if (response.statusCode == 201) {
        user.value = response.payload;
        return true;
      } else {
        Get.snackbar("Error", response.message);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
