import 'package:get/get.dart';

import '../controllers/primary_assessment_controller.dart';

class PrimaryAssessmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrimaryAssessmentController());
  }
}
