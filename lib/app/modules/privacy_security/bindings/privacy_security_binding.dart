import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/privacy_security/controllers/privacy_security_controller.dart';



class PrivacySecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacySecurityController());
  }
}
