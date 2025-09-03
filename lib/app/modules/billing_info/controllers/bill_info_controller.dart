import 'package:get/get.dart';

import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../../data/repository/profile_repository.dart';
import '../models/billing_info_model.dart';

class BillingController extends GetxController {
  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());
  final ProfileRepository _repository =
  Get.find(tag: (ProfileRepository).toString());

  final AuthenticationRepository authenticationRepository =
  Get.find(tag: (AuthenticationRepository).toString());
  @override
  void onInit() {
    super.onInit();
    loadBillingInfo();
  }
  var billingList = <BillingInfoModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

  Future<void> loadBillingInfo() async {
    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');
    try {
      isLoading.value = true;
      error.value = '';
      final data = await _repository.fetchBillingInfo(token,userId);
      billingList.assignAll(data);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  final transactions = [
    {
      'child': 'Oliver',
      'title': 'Full Assessment',
      'subtitle': 'ADHD Diagnosis Assessment',
      'trxId': 'AG45785432567',
      'amount': '+ £120.99',
      'time': '04:35pm, 25/07/2025',
    },
    {
      'child': 'Oliver',
      'title': 'Full Assessment',
      'subtitle': 'ADHD Diagnosis Assessment',
      'trxId': 'AG45785432567',
      'amount': '+ £120.99',
      'time': '04:35pm, 25/07/2025',
    },
    {
      'child': 'Oliver',
      'title': 'Full Assessment',
      'subtitle': 'ADHD Diagnosis Assessment',
      'trxId': 'AG45785432567',
      'amount': '+ £120.99',
      'time': '04:35pm, 25/07/2025',
    },
  ].obs;
}
