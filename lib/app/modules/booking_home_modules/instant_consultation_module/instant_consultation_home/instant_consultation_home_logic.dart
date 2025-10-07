import 'package:get/get.dart';

import '../../../../base_controller/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/models/home_service.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/profile_repository.dart';
import '../../../../routes/app_route_names.dart';
import '../../../../core/assets_helper/app_images.dart';
import '../../../../utils/ext_storage.dart';
import '../instant_consultation_states/instant_consultation_states_logic.dart';

class InstantConsultationHomeLogic extends BaseController {
  final ProfileRepository _profileRepository = ProfileRepository();
  List<AppUser> members = [];
static bool fromInstantConsultation=false;
  AppUser? selectedPatient;

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
      buildFailedSnackBar(msg: AppStrings.pleaseSelectPatientMsg.tr);
    }
  }

  navToPreviousPrescriptions() async{
    if (selectedPatient != null) {
      var homeService = HomeService(
          id: 1,
          name: AppStrings.prescriptionList,
          icon: AppImages.iconMedicineList,
          route: AppRouteNames.radiologyLabFiles,
          primary: true,
          code: 'IC',
          user: selectedPatient);




      if(await ExtStorage.getStoragePermission()==true){

    Get.toNamed(AppRouteNames.radiologyLabFiles, arguments: homeService);


    }
    else{

    buildFailedSnackBar(msg: AppStrings.storagePermissionRequired.tr,duration: 10);

    }





      //   Get.toNamed(RequestPage.routeName,arguments: selectedPatient!.id);

    } else {
      buildFailedSnackBar(msg: AppStrings.selectPatientMsg.tr);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    BookingConstants.reset();
    if(currentUser !=null){
    fetch();}

  }



}
