// controllers/signin_controller.dart

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

  ///////


  // static const String serverClientId =
  //     '145142242234-0iqpp3ufsp438j1enf2lk773naheikcn.apps.googleusercontent.com';
  //
  //
  // final AuthService _authService = AuthService(
  //   // Provide serverClientId if your Android needs the web client id (see note below)
  //   serverClientId: '145142242234-0iqpp3ufsp438j1enf2lk773naheikcn.apps.googleusercontent.com',
  // );


  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    // user.bindStream(FirebaseAuth.instance.authStateChanges());
  }
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  /// Google
  Future<void> signInWithGoogleAndSendToBackend() async {

    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // user cancelled
      return;
    }
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      // accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    final idToken = await userCredential.user!.getIdToken();
    print("idToken ${idToken}");

    // send to backend
    // final resp = await http.post(
    //   Uri.parse('$backendUrl/auth/firebase'),
    //   headers: {
    //     'Authorization': 'Bearer $idToken',
    //     'Content-Type': 'application/json',
    //   },
    // );
    //
    // if (resp.statusCode != 200) {
    //   throw Exception('Backend auth error: ${resp.statusCode} ${resp.body}');
    // }
  }




  // Future<void> signInWithFacebook() async {
  //   try {
  //     isLoading.value = true;
  //
  //     final fbResult = await FacebookSignInService.signInWithFacebook();
  //
  //     if (fbResult != null) {
  //       fbToken.value = fbResult['accessToken'] ?? '';
  //       fbName.value = fbResult['name'] ?? '';
  //       fbEmail.value = fbResult['email'] ?? '';
  //       fbPicture.value = fbResult['picture'] ?? '';
  //
  //       print("✅ FB Token: ${fbToken.value}");
  //       print("✅ User Name: ${fbName.value}");
  //       print("✅ User Email: ${fbEmail.value}");
  //     } else {
  //       print("⚠️ Facebook login cancelled or failed");
  //     }
  //   } catch (e) {
  //     print("❌ Facebook login error: $e");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  /// Facebook logout
  // Future<void> logoutFromFacebook() async {
  //   await FacebookSignInService.signOut();
  //   fbToken.value = '';
  //   fbName.value = '';
  //   fbEmail.value = '';
  //   fbPicture.value = '';
  //   print("✅ Logged out from Facebook");
  // }

  ///Apple
  ///
  /// final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  //   Future<void> signInWithApple() async {
  //     try {
  //       final credential = await SignInWithApple.getAppleIDCredential(
  //         scopes: [
  //           AppleIDAuthorizationScopes.email,
  //           AppleIDAuthorizationScopes.fullName,
  //         ],
  //       );
  //
  //       final oauthCredential = OAuthProvider("apple.com").credential(
  //         idToken: credential.identityToken,
  //         accessToken: credential.authorizationCode,
  //       );
  //
  //       await _auth.signInWithCredential(oauthCredential);
  //
  //       Get.snackbar("Success", "Signed in with Apple");
  //     } catch (e) {
  //       Get.snackbar("Error", e.toString());
  //     }
  //   }
  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],

        // 🔹 Web / Android specific
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.example.neuroCheckPro.service', // Your Service ID
          redirectUri: Uri.parse(
              'https://neuro-check-pro.firebaseapp.com/__/auth/handler'), // Firebase redirect URL
        ),
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );
      print("Apple Firebase ID Token: $oauthCredential");

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      final idToken = await userCredential.user?.getIdToken();
      print("Apple Firebase ID Token: $idToken");
    } catch (e) {
      print("Apple Sign-In Error: $e");
    }
  }

  // Future<void> signInWithApple() async {
  //   try {
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //
  //     final oauthCredential = OAuthProvider("apple.com").credential(
  //       idToken: credential.identityToken,
  //       accessToken: credential.authorizationCode,
  //     );
  //
  //     final userCredential = await _auth.signInWithCredential(oauthCredential);
  //
  //     // Firebase ID token
  //     final idToken = await userCredential.user?.getIdToken();
  //
  //     // Send idToken to your backend for verification
  //     print("Apple Firebase ID Token: $idToken");
  //
  //   } catch (e) {
  //     print("Apple Sign-In Error: $e");
  //   }
  // }
  //

  void goToSignUp() {
    Get.toNamed('/signup_view');
  }

  void goToSignUpForm() {
    Get.toNamed('/signup_form');
  }
  /////



}
