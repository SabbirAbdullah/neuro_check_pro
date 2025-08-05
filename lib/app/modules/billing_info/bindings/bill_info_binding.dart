import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/billing_info/controllers/bill_info_controller.dart';

class BillInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BillingController());
  }
}
