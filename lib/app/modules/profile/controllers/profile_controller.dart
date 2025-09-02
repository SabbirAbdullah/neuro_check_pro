import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/data/repository/profile_repository.dart';
import 'package:neuro_check_pro/app/modules/onboardings/controllers/onboarding_controller.dart';

import '../../../data/model/user_info_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';

class ProfileController extends GetxController {


  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());
  final ProfileRepository _repository =
  Get.find(tag: (ProfileRepository).toString());

  final AuthenticationRepository authenticationRepository =
  Get.find(tag: (AuthenticationRepository).toString());

  TextEditingController nameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final Rx<File?> selectedImage = Rx<File?>(null);

  var isLoading = false.obs;
  var user = Rxn<UserInfoModel>();

  Future<void> updateUserInfo(Map<String, dynamic> data) async {
    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');
    isLoading.value = true;
    try {

      final updatedUser = await _repository.updateUser(userId, data, token);
      user.value = updatedUser;

      Get.back();
      Get.snackbar("Success", "Profile updated successfully");

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  // Future<bool> fetchUserInfo() async {
  //   final token = await _prefRepository.getString('token');
  //   final id = await _prefRepository.getInt('id');
  //   if (token.isEmpty || id == null) return false;
  //
  //   try {
  //     isLoading.value = true;
  //     final response = await authenticationRepository.getUserById(id, token);
  //
  //     if (response.statusCode == 201) {
  //       user.value = response.payload;
  //       return true;
  //     } else {
  //       Get.snackbar("Error", response.message);
  //       return false;
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", e.toString());
  //     return false;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> logout() async {
    await _prefRepository.remove('token');
    await _prefRepository.remove('id');
    // Get.delete<OnboardingController>();
    // Navigate to onboarding or login screen
    Get.offAllNamed('/signin_view');
  }

  /// Open image picker
  Future<void> pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  /// Delete image
  void deleteImage() {
    selectedImage.value = null;
  }
}
