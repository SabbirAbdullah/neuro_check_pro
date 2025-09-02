import 'package:get/get.dart';

// controllers/dashboard_controller.dart
import 'package:get/get.dart';

import '../../../data/model/user_info_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
  @override
  void onInit() {
    super.onInit();
    // checkLoginStatus();
    // fetchUserInfo();
  }
  final PrefRepository _prefRepo = Get.find(tag: (PrefRepository).toString());
  final AuthenticationRepository _repository =
  Get.find(tag: (AuthenticationRepository).toString());

  var user = Rxn<UserInfoModel>();
  var isLoading = false.obs;
  //
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
