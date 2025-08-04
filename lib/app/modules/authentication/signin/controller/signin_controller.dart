// controllers/signin_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signIn() {
    // Add validation + API call/Firebase logic
    final emailOrPhone = emailOrPhoneController.text.trim();
    final password = passwordController.text.trim();

    if (emailOrPhone.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter email/phone and password');
      return;
    }

    // Implement your sign-in logic here
    print('Signing in with: $emailOrPhone');
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
