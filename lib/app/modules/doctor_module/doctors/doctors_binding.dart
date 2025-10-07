import 'package:get/get.dart';

import 'doctors_controller.dart';

class DoctorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorsController());
  }
}
