
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;


import 'package:neuro_check_pro/app/network/dio_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Google Sign-In Service Class
class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;
  static final  _dio = DioProvider.dioWithHeaderToken;
  static final  dio = Dio();

  static Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '145142242234-0iqpp3ufsp438j1enf2lk773naheikcn.apps.googleusercontent.com',
      );
    }
    isInitialize = true;
  }

  // static Future<String?> signInWithGoogle() async {
  //   try {
  //     initSignIn();
  //     final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
  //     final idToken = googleUser.authentication.idToken;
  //     final authorizationClient = googleUser.authorizationClient;
  //     GoogleSignInClientAuthorization? authorization = await authorizationClient
  //         .authorizationForScopes(['email', 'profile']);
  //     final accessToken = authorization?.accessToken;
  //     if (accessToken == null) {
  //       final authorization2 = await authorizationClient.authorizationForScopes(
  //         ['email', 'profile'],
  //       );
  //       if (authorization2?.accessToken == null) {
  //         throw FirebaseAuthException(code: "error", message: "error");
  //       }
  //       authorization = authorization2;
  //     }
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: accessToken,
  //       idToken: idToken,
  //     );
  //     final UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithCredential(credential);
  //
  //     // Step 3: Get Firebase ID Token (THIS is what backend needs)
  //     final firebaseIdToken = await userCredential.user!.getIdToken();
  //
  //     // Step 4: Send Firebase ID Token to backend
  //     final response = await _dio.post(
  //             'https://neurocheckpro.com/api/auth/social-login',
  //             data: jsonEncode({'idToken': firebaseIdToken}),
  //
  //           );
  //           print(firebaseIdToken);
  //     print("idToken : $firebaseIdToken");
  //
  //     print("Backend response: ${response.data}");
  //     return firebaseIdToken;
  //   } catch (e) {
  //     print('Error: $e');
  //     rethrow;
  //   }
  // }
  static Future<String?> signInWithGoogle() async {
    try {
      initSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient.authorizationForScopes(['email', 'profile']);

      final accessToken = authorization?.accessToken;

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      print("👉 Google idToken $idToken");
      print("👉 Access token $accessToken");
      print("👉 Credential token $credential");

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;


      final String? firebaseIdToken = await user?.getIdToken();

      if (firebaseIdToken == null) return null;

      print(jsonEncode({'idToken': firebaseIdToken}));


      final response = await _dio.post(
        'https://neurocheckpro.com/api/auth/social-login',
        data: jsonEncode({'idToken': firebaseIdToken}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      print("Backend response: ${response.data}");

      return firebaseIdToken;

    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }




  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}




class AppleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithApple() async {
    try {
      // Step 1: Request Apple credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Step 2: Build OAuth credential for Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Step 3: Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      return userCredential;
    } catch (e) {
      print("Apple Sign-In error: $e");
      return null;
    }
  }
}

