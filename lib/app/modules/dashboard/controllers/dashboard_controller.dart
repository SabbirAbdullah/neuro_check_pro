import 'package:get/get.dart';

// controllers/dashboard_controller.dart
import 'package:get/get.dart';

import '../../../data/repository/pref_repository.dart';
import '../../../data/repository/profile_repository.dart';
import '../models/blog_model.dart';

class DashboardController extends GetxController {
  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());
  final ProfileRepository _repository =
  Get.find(tag: (ProfileRepository).toString());

  // final AuthenticationRepository authenticationRepository =
  // Get.find(tag: (AuthenticationRepository).toString());

  // Carousel images
  final carouselImages = [
    'assets/images/carousul.png',
    'assets/images/carousul.png',
    'assets/images/carousul.png',
    'assets/images/carousul.png',
  ];
  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
    // fetchUserInfo();
  }
  var blogs = <BlogModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> fetchBlogs() async {
    final token = await _prefRepository.getString('token');
    try {
      isLoading.value = true;
      error.value = '';
      final data = await _repository.getBlogs(token);
      blogs.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
