import 'package:get/get.dart';

// controllers/dashboard_controller.dart
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

}
