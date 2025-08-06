import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacySecurityController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future <void> changePassword() async{
    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "Passwords do not match",
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    await Future.delayed(Duration(seconds: 1));
    Get.back();
    // Call API or logic here
    Get.snackbar(
      "Success",
      "Password changed successfully",

      snackPosition: SnackPosition.TOP,
    );

    // Clear fields
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();

  }
}
