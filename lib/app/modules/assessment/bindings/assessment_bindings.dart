import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/assessment/controllers/assessment_controller.dart';



class AssessmentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssessmentController());
  }
}
