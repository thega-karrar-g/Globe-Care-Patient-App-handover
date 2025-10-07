import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_route_names.dart';

class OurServicesLogic extends GetxController {
  GetStorage introBox = GetStorage();

  navToLogin() {
    introBox.write('displayed', 3);

    Get.offAllNamed(AppRouteNames.homeTabs);
  }
}
