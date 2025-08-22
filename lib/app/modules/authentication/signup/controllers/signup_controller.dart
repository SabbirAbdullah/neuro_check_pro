// controllers/signup_controller.dart
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/authentication/signup/views/signup_form.dart';
import 'package:neuro_check_pro/app/modules/authentication/signup/views/signup_view.dart';
import 'package:neuro_check_pro/app/modules/authentication/signup/widgets/phone/otp_verify.dart';

import '../../../../core/values/text_styles.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../../../data/repository/pref_repository.dart';
import '../models/otp_model.dart';
import '../models/signup_model.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final stateController = TextEditingController();
  final postcodeController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  // Dropdown Selections
  final roleList = ["Parent", "Carer"];
  final selectedRole = RxnString();

  final howKnowList = ["Friend", "Facebook", "Instagram"];
  final selectedOption = RxnString();

  // Password
  var password = "".obs;
  var confirmPassword = "".obs;
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void togglePasswordVisibility() =>
      isPasswordHidden.value = !isPasswordHidden.value;
  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  final AuthenticationRepository _repository =
      Get.find(tag: (AuthenticationRepository).toString());
  final PrefRepository _prefRepository =
      Get.find(tag: (PrefRepository).toString());
  var otpCode = "".obs;
  var identifier = "".obs; // email or phone

  // For phone input
  var phoneNumber = "";
  var countryCode = "";
  void updatePhone(String number) => phoneNumber = number;
  void updateCountryCode(String code) => countryCode = code;

  // For email input


  // Loading
  var isLoading = false.obs;

  Future<void> submitForm() async {
    if (password.value != confirmPassword.value) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;
    try {
      final request = SignupRequest(
        name: nameController.text.trim(),
        email: identifier.contains("@") ? identifier.value : emailController.text.trim(),
        password: password.value,
        phone: identifier.contains("@") ? "" : identifier.value,
        age: int.tryParse(ageController.text.trim()) ?? 0,
        country: selectedCountry.value.name,
        state: stateController.text.trim(),
        postCode: postcodeController.text.trim(),
        street: addressController.text.trim(),
        role: selectedRole.value ?? "user",
        knowHow: selectedOption.value ?? "Friend",
        identifier: identifier.value,
        otp: otpCode.value,
      );

      final response = await _repository.signup(request);

      if (response.statusCode == 201) {
        await _prefRepository.setString('token', response.token.accessToken);
        await _prefRepository.setInt('id', response.user.id);
        Get.snackbar("Success", response.message);
        showUKUserAlertDialog();
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  var selectedCountry = Country(
    countryCode: 'GB',
    name: 'United Kingdom',
    phoneCode: '',
    e164Sc: 0,
    geographic: false,
    displayName: '',
    displayNameNoCountryCode: '',
    level: 0,
    e164Key: '',
    example: '',
  ).obs;

  void sendOtp() async {
    if (phoneNumber.isNotEmpty) {
      identifier.value = "$countryCode$phoneNumber";
    } else if (emailController.text.isNotEmpty) {
      identifier.value = emailController.text.trim();
    }

    if (identifier.value.isEmpty) {
      Get.snackbar("Error", "Please enter your phone or email");
      return;
    }

    isLoading.value = true;
    try {
      final request = SendOtpRequest(identifier: identifier.value);
      final response = await _repository.sendOtp(request);

      if (response.statusCode == 201) {
        Get.snackbar("Success", response.message);
        Get.to(() => OtpPhone(), arguments: identifier.value);
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void verifyOtp() async {
    if (otpCode.value.length != 4) {
      Get.snackbar('Error', 'Please enter a valid 4-digit OTP');
      return;
    }

    isLoading.value = true;
    try {
      final request = VerifyOtpRequest(
        identifier: identifier.value,
        otp: otpCode.value,
      );
      final response = await _repository.verifyOtp(request);

      if (response.statusCode == 200 && response.verified) {
        Get.snackbar("Success", response.message);
        // We already have identifier + otpCode in controller
        Get.offAll(() => SignupForm());
      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///////////////////

  void signUpWithPhone() {
    // Navigate to phone signup page
    Get.toNamed('/signup_phone');
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

  void showUKUserAlertDialog() {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Text(
          'NeuroCheckPro is designed for UK users',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Assessments and diagnoses are tailored to UK clinical standards and may not align with practices in your country.',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back(); // dismiss the dialog
            },
            child: const Text(
              'Cancel',
              style: textButton_blue,
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: false,
            onPressed: () {
              showPrivacyPolicyDialog();
              // Handle Okay action
              // Get.back();
            },
            child: const Text(
              'Okay',
              style: textButton_blue,
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void showPrivacyPolicyDialog() {
    final RxBool isChecked = false.obs;

    Get.dialog(
      Obx(() => CupertinoAlertDialog(
            title: const Text(
              "Your Privacy Matters",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              children: [
                const SizedBox(height: 12),
                const Text(
                  "We value your privacy and handle your personal data in accordance with GDPR. Your information will only be used for assessment and clinical purposes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: CupertinoCheckbox(
                        value: isChecked.value,
                        onChanged: (value) {
                          isChecked.value = value!;
                          if (value) {
                            bottomNavigation();
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black, fontSize: 13.5),
                            children: [
                              const TextSpan(text: "I agree to our "),
                              TextSpan(
                                text: "Terms of Service",
                                style: const TextStyle(
                                    color: CupertinoColors.activeBlue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Open Terms of Service
                                  },
                              ),
                              const TextSpan(text: " and "),
                              TextSpan(
                                text: "Privacy Policy.",
                                style: const TextStyle(
                                    color: CupertinoColors.activeBlue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: Open Privacy Policy
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            actions: const [],
          )),
      barrierDismissible: false,
    );
  }
}
