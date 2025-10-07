import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../../routes/app_route_names.dart';

class MainDrawerWidgetController extends BaseController {
  navToEmergencyContact() {
    return Get.toNamed(AppRouteNames.emergencyContactListView);
  }
}
