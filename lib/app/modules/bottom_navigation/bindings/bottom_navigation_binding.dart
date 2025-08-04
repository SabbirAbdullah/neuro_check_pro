import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:neuro_check_pro/app/modules/dashboard/controllers/dashboard_controller.dart';


class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationController());
  }
}
