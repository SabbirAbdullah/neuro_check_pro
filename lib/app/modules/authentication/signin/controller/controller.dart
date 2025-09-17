// import 'dart:ui';
//
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class EmailAuthController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//
//   var isLoading = false.obs;
//   var isSignedIn = false.obs;
//   var userName = ''.obs;
//   var userEmail = ''.obs;
//   var userId = ''.obs;
//
//   /// Sign up with email & password
//   Future<void> signUp(String name, String email, String password) async {
//     try {
//       isLoading.value = true;
//
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       User? user = userCredential.user;
//       if (user != null) {
//         // Save user info in Firestore
//         await _firestore.collection("users").doc(user.uid).set({
//           "uid": user.uid,
//           "name": name,
//           "email": email,
//           "createdAt": FieldValue.serverTimestamp(),
//         });
//
//         // Update state
//         isSignedIn.value = true;
//         userName.value = name;
//         userEmail.value = email;
//         userId.value = user.uid;
// print("YEEREEREEEEEEEEESSS");
//         /// ✅ Success Snackbar
//         Get.snackbar(
//           "Success",
//           "Account created successfully 🎉",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: const Color(0xFF4CAF50),
//           colorText: const Color(0xFFFFFFFF),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       /// ❌ Error Snackbar
//       Get.snackbar(
//         "Sign Up Failed",
//         e.message ?? "Unknown error",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: const Color(0xFFF44336),
//         colorText: const Color(0xFFFFFFFF),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Login with email & password
//   Future<void> login(String email, String password) async {
//     try {
//       isLoading.value = true;
//
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       User? user = userCredential.user;
//       print("My email: ${user!.email}");
//       Get.snackbar(
//         "Welcome Back",
//         "Login successful 🎉",
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: const Color(0xFF4CAF50),
//         colorText: const Color(0xFFFFFFFF),
//       );
//       if (user != null) {
//         // Fetch user data from Firestore
//         DocumentSnapshot userDoc =
//         await _firestore.collection("users").doc(user.uid).get();
//
//         if (userDoc.exists) {
//           userName.value = userDoc["name"];
//           userEmail.value = userDoc["email"];
//           userId.value = user.uid;
//           isSignedIn.value = true;
//
//
//           /// ✅ Success Snackbar
//
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       /// ❌ Error Snackbar
//       Get.snackbar(
//         "Login Failed",
//         e.message ?? "Unknown error",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: const Color(0xFFF44336),
//         colorText: const Color(0xFFFFFFFF),
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Logout
//   Future<void> logout() async {
//     await _auth.signOut();
//     isSignedIn.value = false;
//     userName.value = "";
//     userEmail.value = "";
//     userId.value = "";
//
//     /// ✅ Logout Snackbar
//     Get.snackbar(
//       "Logged Out",
//       "You have been signed out.",
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: const Color(0xFF2196F3),
//       colorText: const Color(0xFFFFFFFF),
//     );
//   }
// }
//


