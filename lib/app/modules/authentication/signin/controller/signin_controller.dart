// controllers/signin_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:neuro_check_pro/app/modules/welcome/controllers/splash_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/local/preference/preference_manager.dart';
import '../../../../data/model/user_info_model.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../../../data/repository/pref_repository.dart';
import '../../../onboardings/controllers/onboarding_controller.dart';
import '../model/login_model.dart';


class SignInController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var loginMethod = "Email".obs; // Default

  final AuthenticationRepository _repository =
      Get.find(tag: (AuthenticationRepository).toString());
  final PrefRepository _prefRepository =
      Get.find(tag: (PrefRepository).toString());

  var isLoading = false.obs;
  var countryCode = "+44";
   Rxn <LoginResponse> loginResponse = Rxn<LoginResponse>();
  var isPhoneMode = true.obs;
  final dialNumberController = TextEditingController();

  void toggleMode(bool phoneMode) {
    isPhoneMode.value = phoneMode;
    dialNumberController.clear(); // clear the field
  }

  Future<void> login() async {
   final identifier = loginMethod.value == "Phone"
       ? "$countryCode${emailOrPhoneController.text.trim()}"
       : emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();

    if (identifier.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter all fields");
      return;
    }
    isLoading.value = true;
    try {
      final request = LoginRequest(identifier: identifier, password: password);
      final response = await _repository.login(request);

      if (response.statusCode == 200) {
        await _prefRepository.setString('token', response.token.accessToken);
         await _prefRepository.setInt('id', response.user.id );
        Get.snackbar("Success", response.message);

        final user = Get.put(OnboardingController());
        await user.fetchUserInfo();

        Get.offAllNamed("/bottom_navigation_view"); // Navigate to Dashboard
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error",e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    dialNumberController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void forgotPassword() {
    Get.toNamed('/forgot-password');
  }

  void signInWithGoogle() {
    print('Google sign-in triggered');
  }

  void signInWithApple() {
    print('Apple sign-in triggered');
  }

  void signInWithFacebook() {
    print('Facebook sign-in triggered');
  }

  void goToSignUp() {
    Get.toNamed('/signup_view');
  }

  void goToSignUpForm() {
    Get.toNamed('/signup_form');
  }



}
