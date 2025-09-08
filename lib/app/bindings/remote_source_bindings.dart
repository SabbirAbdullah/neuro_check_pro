
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/remote/profile_remote_data_impl.dart';
import 'package:neuro_check_pro/app/data/remote/profile_remote_data_source.dart';

import '../data/remote/assessment_remote_data_impl.dart';
import '../data/remote/assessment_remote_data_source.dart';
import '../data/remote/auth_remote_data_impl.dart';
import '../data/remote/auth_remote_data_source.dart';
import '../data/remote/patient_remote_data_impl.dart';
import '../data/remote/patient_remote_data_source.dart';
import '../modules/welcome/controllers/splash_controller.dart';


class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {

    Get.lazyPut<AuthenticationRemoteDataSource>(
          () => AuthenticationRemoteDataImpl(),
      tag: (AuthenticationRemoteDataSource).toString(),
      fenix: true,
    );

    Get.lazyPut<PatientRemoteDataSource>(
          () => PatientRemoteDataSourceImpl(),
      tag: (PatientRemoteDataSource).toString(),
      fenix: true,
    );

    Get.lazyPut<AssessmentRemoteDataSource>(
          () => AssessmentRemoteDataSourceImpl(),
      tag: (AssessmentRemoteDataSource).toString(),
      fenix: true,
    );

    Get.lazyPut<ProfileRemoteDataSource>(
          () => ProfileRemoteDataImpl(),
      tag: (ProfileRemoteDataSource).toString(),
      fenix: true,
    );

  }

}
