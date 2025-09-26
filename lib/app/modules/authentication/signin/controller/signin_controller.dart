// controllers/signin_controller.dart

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:neuro_check_pro/app/modules/welcome/controllers/splash_controller.dart';
import 'package:neuro_check_pro/app/network/dio_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../data/repository/auth_repository.dart';
import '../../../../data/repository/pref_repository.dart';

import '../model/login_model.dart';
import 'google_service.dart';

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
  Rxn<LoginResponse> loginResponse = Rxn<LoginResponse>();
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
        await _prefRepository.setInt('id', response.user.id);
        Get.snackbar("Success", response.message);

        final user = Get.put(SplashController());
        await user.fetchUserInfo();

        Get.offAllNamed("/bottom_navigation_view"); // Navigate to Dashboard
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
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
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loading = false;

  Future<void> handleGoogleSignIn() async {
    loading = true;
    try {
      final String? user= await GoogleSignInService.signInWithGoogle();

      if (user != null) {
        Get.snackbar("Signed in as ", user);

        // 👉 Navigate to home page or dashboard
        // Navigator.pushReplacementNamed(context, '/home');
      } else {
        Get.snackbar("Sign-in was cancelled",user!);
      }
    } catch (e) {
      Get.snackbar("Sign-in failed", e.toString());

    } finally {
      loading = false;
    }
  }
  var user = Rxn<User>();


  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredential);

      // Firebase ID token
      final idToken = await userCredential.user?.getIdToken();

      // Send idToken to your backend for verification
      print("Apple Firebase ID Token: $idToken");

    } catch (e) {
      print("Apple Sign-In Error: $e");
    }
  }


  void goToSignUp() {
    Get.toNamed('/signup_view');
  }

  void goToSignUpForm() {
    Get.toNamed('/signup_form');
  }



}