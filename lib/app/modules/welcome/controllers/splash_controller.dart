import 'dart:async';

import 'package:get/get.dart';

import '../../../data/model/user_info_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../bottom_navigation/views/bottom_navigation_view.dart';

// class SplashController extends GetxController {
//   var currentPage = 0.obs;
//   final PrefRepository _prefRepo =
//   Get.find(tag: (PrefRepository).toString());
//   final AuthenticationRepository _repository =
//   Get.find(tag: (AuthenticationRepository).toString());
//
//   var user = Rxn<UserInfoModel>();
//   var isLoading = false.obs;
//
//
//   @override
//   void onReady() {
//     super.onReady();
//     checkLoginStatus();
//   }
//
//   Future<void> checkLoginStatus() async {
//     await Future.delayed(const Duration(seconds: 1)); // splash delay
//
//     final token = await _prefRepo.getString('token');
//     final id = await _prefRepo.getInt('id');
//     final isFirstInstall = await _prefRepo.getBool('isFirstInstall') ?? true;
//
//     if (isFirstInstall) {
//       await _prefRepo.setBool('isFirstInstall', false);
//       Get.offAllNamed('/onboarding_view');
//       return;
//     }
//
//     if (token != null && token.isNotEmpty && id != null) {
//       // logged in
//       final success = await fetchUserInfo();
//       if (success) {
//         Get.offAll(() => BottomNavigationView());
//       } else {
//         await _prefRepo.clear();
//         Get.offAllNamed('/signin_view');
//       }
//     } else {
//       // not first install, but not logged in
//       Get.offAllNamed('/signin_view');
//     }
//   }
//
//   Future<bool> fetchUserInfo() async {
//     final token = await _prefRepo.getString('token');
//     final id = await _prefRepo.getInt('id');
//
//     if (token == null || token.isEmpty || id == null) return false;
//
//     try {
//       isLoading.value = true;
//       final response = await _repository.getUserById(id, token);
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         user.value = response.payload; // assign user
//         return true;
//       } else {
//         if (!Get.isSnackbarOpen) {
//           Get.snackbar("Error", response.message ?? "Something went wrong");
//         }
//         return false;
//       }
//     } catch (e) {
//       if (!Get.isSnackbarOpen) {
//         Get.snackbar("Error", e.toString());
//       }
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   // Future<void> checkLoginStatus() async {
//   //   final token = await _prefRepo.getString('token');
//   //   final id = await _prefRepo.getInt('id');
//   //
//   //   if (token != null && token.isNotEmpty && id != null) {
//   //     // logged in
//   //     final success = await fetchUserInfo();
//   //     if (success) {
//   //       Get.offAll(() => BottomNavigationView());
//   //     } else {
//   //       await _prefRepo.clear();
//   //       Get.offAllNamed('/signin_view');
//   //     }
//   //   } else {
//   //       Get.offAllNamed('/onboarding_view');
//   //     }
//   //
//   // }
//   //
//   // Future<bool> fetchUserInfo() async {
//   //   final token = await _prefRepo.getString('token');
//   //   final id = await _prefRepo.getInt('id');
//   //
//   //   if (token == null || token.isEmpty || id == null) return false;
//   //
//   //   try {
//   //     isLoading.value = true;
//   //     final response = await _repository.getUserById(id, token);
//   //
//   //     if (response.statusCode == 200 || response.statusCode == 201) {
//   //       user.value = response.payload;
//   //       return true;
//   //     } else {
//   //       if (!Get.isSnackbarOpen) {
//   //         Get.snackbar("Error", response.message ?? "Something went wrong");
//   //       }
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     if (!Get.isSnackbarOpen) {
//   //       Get.snackbar("Error", e.toString());
//   //     }
//   //     return false;
//   //   } finally {
//   //     isLoading.value = false;
//   //   }
//   // }
// }
