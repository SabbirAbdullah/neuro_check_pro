import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/onboardings/controllers/onboarding_controller.dart';
import '../modules/welcome/controllers/splash_controller.dart';
import 'local_source_bindings.dart';
import 'remote_source_bindings.dart';
import 'repository_bindings.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RepositoryBindings().dependencies();
    RemoteSourceBindings().dependencies();
    LocalSourceBindings().dependencies();
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);

  }
}