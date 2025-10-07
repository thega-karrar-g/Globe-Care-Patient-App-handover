import 'package:get/get.dart';

import '../../base_controller/base_controller.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/profile_repository.dart';
import '../../routes/app_route_names.dart';
import '../booking_home_modules/instant_consultation_module/instant_consultation_states/instant_consultation_states_logic.dart';

class SelectPatientLogic extends BaseController {
  final ProfileRepository _profileRepository = ProfileRepository();
  List<AppUser> members = [];

  static AppUser? selectedPatient;

  fetch() async {
    members.clear();
    members.add(currentUser!);
    setBusy(true);
    var list = await _profileRepository.getMemberList();
    members.addAll(list);
    setBusy(false);
    update();
  }

  updateSelectedPatient(AppUser user) {
    selectedPatient = user;

    update();
  }

  selectPatientClick() {
    if (selectedPatient != null) {
     // InstantConsultationStatesLogic.selectedPatient = selectedPatient;
      Get.toNamed(
        AppRouteNames.instantConsultation,
      );
    } else {
      buildFailedSnackBar(msg: AppStrings.selectPatientMsg.tr);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if(currentUser !=null) {
      fetch();
    }
  }
}
