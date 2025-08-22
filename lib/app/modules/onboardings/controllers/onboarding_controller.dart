// controllers/onboarding_controller.dart
import 'package:get/get.dart';
import 'package:get/get.dart';
import '../../../data/local/preference/preference_manager.dart';
import '../../../data/model/user_info_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';
 // adjust path accordingly

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final PrefRepository _prefRepo = Get.find(tag: (PrefRepository).toString());
  final AuthenticationRepository _repository =
  Get.find(tag: (AuthenticationRepository).toString());
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void nextPage() {
    if (currentPage.value < 3) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  void skipToLast() {
    currentPage.value = 3;
  }
  var user = Rxn<UserInfoModel>();
  var isLoading = false.obs;

  Future<void> checkLoginStatus() async {
    final token = await _prefRepo.getString('token');
    final id = await _prefRepo.getInt('id');

    if (token.isNotEmpty && id != null) {
      final success = await fetchUserInfo();
      if (success) {
        Get.offNamed('/bottom_navigation_view'); // ✅ only if valid
      } else {
        await _prefRepo.clear(); // clear invalid token/id
        Get.offAllNamed('/signin_view'); // back to login
      }
    } else {
      Get.offAllNamed('/signin_view');
    }
  }

  Future<bool> fetchUserInfo() async {
    final token = await _prefRepo.getString('token');
    final id = await _prefRepo.getInt('id');
    if (token.isEmpty || id == null) return false;

    try {
      isLoading.value = true;
      final response = await _repository.getUserById(id, token);

      if (response.statusCode == 201) {
        user.value = response.payload;
        return true; // ✅ success
      } else {
        Get.snackbar("Error", response.message);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }


}
