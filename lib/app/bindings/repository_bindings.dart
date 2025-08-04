
import 'package:get/get.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<ParentsRepository>(
    //         () => ParentsRepositoryImpl(),
    //     tag: (ParentsRepository).toString(),
    //     fenix: true
    // );
  }
}