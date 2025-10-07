import 'package:get/get.dart';

import 'medical_file_logic.dart';

class MedicalFileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => MedicalFileLogic(),);
  }
}
