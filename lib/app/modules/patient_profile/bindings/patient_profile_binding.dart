import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/patient_profile/controllers/patient_profile_controller.dart';

class PatientProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PatientProfileController());
  }
}
