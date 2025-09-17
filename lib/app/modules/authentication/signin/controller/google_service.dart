// Google Sign-In Service Class
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:google_sign_in/google_sign_in.dart';

// services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';

//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   final GoogleSignIn _googleSignIn ;
//
//
//   final List<String> _scopes;
//
//   // Optionally pass clientId/serverClientId when creating the service
//   AuthService({
//     String? clientId,
//     String? serverClientId,
//     List<String>? scopes,
//   })  : _scopes = scopes ?? const ['email', 'profile', 'openid'],
//         _googleSignIn = GoogleSignIn.instance;
//
//   /// Call once before attempting authentication flows.
//   Future<void> init() async {
//     // initialize must be awaited before other calls (v7+).
//     await _googleSignIn.initialize();
//   }
//
//   /// Interactive sign-in using the new `authenticate()` API.
//   Future<UserCredential?> signInWithGoogle() async {
//     await _googleSignIn.initialize();
//
//     GoogleSignInAccount? account;
//
//     // Try silent/lightweight first
//     account = await _googleSignIn.attemptLightweightAuthentication(
//       reportAllExceptions: true,
//     );
//
//     // If no account, fallback to interactive authenticate()
//     if (account == null) {
//       if (_googleSignIn.supportsAuthenticate()) {
//         account = await _googleSignIn.authenticate();
//       } else {
//         // Fallback: show error to user
//         print('Google Sign-In not available on this platform');
//         return null;
//       }
//     }
//
//     if (account == null) {
//       // User cancelled or auth failed
//       print('Google Sign-In returned null account');
//       return null;
//     }
//
//     // ID token for Firebase
//     final auth = account.authentication;
//     final idToken = auth.idToken;
//     if (idToken == null) {
//       print('Google ID token is null');
//       return null;
//     }
//
//     // Optional: access token for API calls
//     String? accessToken;
//     try {
//       final authz = await account.authorizationClient.authorizationForScopes(['email','profile','openid']);
//       accessToken = authz?.accessToken;
//     } catch (e) {
//       accessToken = null; // if platform blocks scopes
//     }
//
//     final credential = GoogleAuthProvider.credential(
//       idToken: idToken,
//       accessToken: accessToken,
//     );
//     print("credential : ${credential}");
//     return FirebaseAuth.instance.signInWithCredential(credential);
//
//   }
//
//
//   /// A 'silent' sign-in attempt: use when you want to try without heavy UI.
//   Future<UserCredential?> signInSilently() async {
//     try {
//       await init();
//       final account =
//       await _googleSignIn.attemptLightweightAuthentication(reportAllExceptions: true);
//       if (account == null) return null;
//
//       final idToken = account.authentication.idToken;
//       final accessToken = (await account.authorizationClient.authorizationForScopes(_scopes))?.accessToken;
//
//       if (idToken == null) return null;
//
//       final credential = GoogleAuthProvider.credential(idToken: idToken, accessToken: accessToken);
//       return await _auth.signInWithCredential(credential);
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
//
//   Future<void> disconnect() async {
//     // revoke app authorization
//     await _googleSignIn.disconnect();
//     await _auth.signOut();
//   }
// }
//


// class FacebookSignInService {
//   static final FacebookAuth _facebookAuth = FacebookAuth.instance;
//
//   /// Sign in with Facebook
//   static Future<Map<String, String>?> signInWithFacebook() async {
//     try {
//       // Trigger Facebook login
//       final LoginResult result = await _facebookAuth.login(
//         permissions: ['email', 'public_profile'],
//       );
//
//       if (result.status == LoginStatus.success) {
//         // Get the access token
//         final AccessToken accessToken = result.accessToken!;
//         print("✅ Facebook Access Token: ${accessToken.tokenString}");
//
//         // Optionally fetch user profile data
//         final userData = await _facebookAuth.getUserData(
//           fields: "id,name,email,picture.width(200)",
//         );
//         print("✅ Facebook User Data: $userData");
//
//         return {
//           "accessToken": accessToken.tokenString,
//           "userId": userData['id'] ?? '',
//           "name": userData['name'] ?? '',
//           "email": userData['email'] ?? '',
//           "picture": userData['picture']['data']['url'] ?? '',
//         };
//       } else if (result.status == LoginStatus.cancelled) {
//         print("⚠️ Facebook login cancelled by user");
//         return null;
//       } else {
//         print("❌ Facebook login failed: ${result.message}");
//         return null;
//       }
//     } catch (e) {
//       print("❌ Facebook Sign-In Error: $e");
//       return null;
//     }
//   }
//
//   /// Sign out
//   static Future<void> signOut() async {
//     await _facebookAuth.logOut();
//     print("✅ Signed out from Facebook");
//   }
// }
