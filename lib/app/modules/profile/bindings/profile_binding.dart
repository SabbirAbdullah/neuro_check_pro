import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/profile/controllers/profile_controller.dart';


class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
