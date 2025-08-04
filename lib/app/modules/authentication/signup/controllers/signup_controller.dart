// controllers/signup_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/authentication/signup/views/signup_form.dart';
import 'package:neuro_check_pro/app/modules/authentication/signup/views/signup_view.dart';
import 'package:neuro_check_pro/app/modules/authentication/signup/widgets/phone/otp_verify.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final stateController = TextEditingController();
  final postcodeController = TextEditingController();
  final addressController = TextEditingController();

  var selectedCountry = "United Kingdom".obs;
  var selectedRole = RxnString();
  var selectedOption = RxnString();

  final roleList = ["Parent", "Carer", "Other"];
  final howKnowList = ["Social Media", "Friends", "Advertisement"];
  var phoneNumber = ''.obs;
  var countryCode = '+44'.obs;

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  var password = ''.obs;
  var confirmPassword = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  void updatePhone(String phone) {
    phoneNumber.value = phone;
  }

  void updateCountryCode(String code) {
    countryCode.value = code;
  }
  void submitForm() {
    if (nameController.text.isEmpty || ageController.text.isEmpty) {
      Get.snackbar("Error", "Please fill required fields");
      return;
    }

    // Submit logic (API/Firebase)
    print("Signup Submitted with: ${nameController.text}");
  }
  // Handle phone signup
  void signUpWithPhone() {
    // Navigate to phone signup page
    Get.toNamed('/signup_phone');
  }

  TextEditingController phoneController = TextEditingController();
  RxString selectedCountryCode = '+44'.obs;


  void sendOtp() {
    // Simulate sending OTP (normally you'll call API here)
    print('Sending OTP to ${selectedCountryCode.value}${phoneController.text}');
    Get.to(()=>OtpPhone());
  }
  RxString otpCode = ''.obs;
  void verifyOtp() {
    if (otpCode.value.length == 6) {
      print('Verifying OTP: ${otpCode.value}');
      Get.to(()=> SignupForm());
    } else {
      Get.snackbar('Error', 'Please enter a valid 6-digit OTP');
    }
  }
  void bottomNavigation() {
    // Navigate to phone signup page
    Get.toNamed('/bottom_navigation_view');
  }

  // Handle email signup
  void signUpWithEmail() {
    Get.toNamed('/email_signin');
  }

  // Handle Google sign in
  void signInWithGoogle() {
    // TODO: integrate Google Sign-In logic
    print("Google Sign-In triggered");
  }

  // Handle Apple sign in
  void signInWithApple() {
    // TODO: integrate Apple Sign-In logic
    print("Apple Sign-In triggered");
  }

  // Handle Facebook sign in
  void signInWithFacebook() {
    // TODO: integrate Facebook Sign-In logic
    print("Facebook Sign-In triggered");
  }

  // Go to Sign In page
  void goToSignIn() {
    Get.toNamed('/signin_view');
  }
}

