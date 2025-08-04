import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/dashboard/controllers/dashboard_controller.dart';


class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
  }
}
