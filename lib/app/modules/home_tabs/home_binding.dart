import 'package:get/get.dart';

import '../appointment/appointment_types_logic.dart';
import '../booking_home_modules/instant_consultation_module/instant_consultation_states/instant_consultation_states_logic.dart';
import '../home_screen/home_screen_controller.dart';
import '../medical_file_module/medical_file/medical_file_logic.dart';
import '../my_profile_module/my_profile/my_profile_logic.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {


    Get.put(() => MedicalFileLogic(),permanent: true);

     Get.put(MyProfileLogic(),permanent: true);
    Get.put(HomeScreenController(),permanent: true);
    Get.put(AppointmentTypesLogic(),permanent: true);
    // Get.put(InstantConsultationStatesLogic(),permanent: true);

  }
}
