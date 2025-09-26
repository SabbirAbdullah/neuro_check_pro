import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/user_info_model.dart';
import '../../../data/repository/pref_repository.dart';
import '../../../data/repository/profile_repository.dart';

class PrivacySecurityController extends GetxController {

  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());
  final ProfileRepository _repository =
  Get.find(tag: (ProfileRepository).toString());

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isCurrentPasswordHidden = true.obs;
  var isNewPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  var user = Rxn<UserInfoModel>();
  var isLoading = false.obs;

  Future<void> changePassword() async {
    String currentPass = currentPasswordController.text.trim();
    String newPass = newPasswordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();

    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');

    // Validation
    if (currentPass.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your current password",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPass.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a new password",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPass.length < 4) {
      Get.snackbar(
        "Error",
        "New password must be at least 6 characters",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (newPass != confirmPass) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // Prepare data to send to API
    final data = {
      "password": confirmPass,
    };

    isLoading.value = true;
    try {
      final updatedUser = await _repository.updateUser(userId, data, token);
      user.value = updatedUser;

      Get.back(); // Close dialog
      Get.snackbar(
        "Success",
        "Password changed successfully",
        snackPosition: SnackPosition.TOP,
      );

      // Clear fields
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }







}
