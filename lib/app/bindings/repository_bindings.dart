
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/repository/profile_repository.dart';
import 'package:neuro_check_pro/app/data/repository/profile_repository_impl.dart';

import '../data/repository/assessment_repository.dart';
import '../data/repository/assessment_repository_impl.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/auth_repository_impl.dart';
import '../data/repository/patient_repository.dart';
import '../data/repository/patient_repository_impl.dart';
import '../data/repository/pref_repository.dart';
import '../data/repository/pref_repository_impl.dart';
import '../modules/welcome/controllers/splash_controller.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {

      Get.lazyPut<AuthenticationRepository>(
              () => AuthenticationRepositoryImpl(),
          tag: (AuthenticationRepository).toString(),
          fenix: true
      );

      Get.lazyPut<PrefRepository>(
              () => PrefRepositoryImpl(),
          tag: (PrefRepository).toString(),
          fenix: true
      );

      Get.lazyPut<PatientRepository>(
            () => PatientRepositoryImpl(),
        tag: (PatientRepository).toString(),
        fenix: true,
      );
      Get.lazyPut<AssessmentRepository>(
            () => AssessmentRepositoryImpl(),
        tag: (AssessmentRepository).toString(),
        fenix: true,
      );

      Get.lazyPut<ProfileRepository>(
            () => ProfileRepositoryImpl(),
        tag: (ProfileRepository).toString(),
        fenix: true,
      );
  }
}


