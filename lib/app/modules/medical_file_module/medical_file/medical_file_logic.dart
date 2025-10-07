import 'package:get/get.dart';
import 'package:globcare/app/data/api/app_urls.dart';
import 'package:globcare/app/modules/caregive_module/caregiver_home/caregiver_home_view.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/home_service.dart';
import '../../../routes/app_route_names.dart';
import '../../../utils/ext_storage.dart';
import '../../select_patient/select_patient_logic.dart';

class MedicalFileLogic extends BaseController {
  List<HomeService> services = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    services = [
      HomeService(
          id: 1,
          name: AppStrings.prescriptionList,
          icon: AppImages.iconMedicineList,
          route: AppRouteNames.radiologyLabFiles,
          primary: true,
          code: 'Prescription',
          user: currentUser,

        url: AppUrls.prescriptionUrls
      ),
      HomeService(
          id: 1,
          name: AppStrings.labTests,
          icon: AppImages.iconLab,
          route: AppRouteNames.radiologyLabFiles,
          primary: true,
          code: 'Lab',
          user: currentUser,
          url: AppUrls.labTestsRequestsUrls


      ),
      HomeService(
          id: 1,
          name: AppStrings.medFileReport,
          icon: AppImages.iconMedicalReport,
          route: AppRouteNames.radiologyLabFiles,
          primary: true,
          code: 'Report',
          user: currentUser,
          url: AppUrls.medicalReportUrls


      ),
      HomeService(
          id: 1,
          name: AppStrings.medFileImageTest,
          icon: AppImages.iconXRay,
          route: AppRouteNames.radiologyLabFiles,
          primary: true,
          code: 'image',
          user: currentUser,
          url: AppUrls.imageTestsRequestsUrls



      ),
      HomeService(
          id: 1,
          name: AppStrings.caregiverFile,
          icon: AppImages.iconCaregiver,
          route: CaregiverHomePage.routeName,
          primary: true,
          code: 'Caregiver',
          user: currentUser),
    ];
  }

  void onTabItem(HomeService homeService,{bool isMedicalFile =true}) async{


    if (homeService.route.isNotEmpty) {
      if (isMedicalFile) {
        if (SelectPatientLogic.selectedPatient != null) {
          homeService.user = SelectPatientLogic.selectedPatient;

          if(homeService.route==AppRouteNames.radiologyLabFiles){


            if(await ExtStorage.getStoragePermission()==true){

    Get.toNamed(homeService.route, arguments: homeService);


    }
    else{

    buildFailedSnackBar(msg: AppStrings.storagePermissionRequired.tr,duration: 10);

    }

    }


    else{

    Get.toNamed(homeService.route, arguments: homeService);


    }


    } else {
    BaseController()
        .buildFailedSnackBar(msg: AppStrings.selectPatientMsg.tr);
    }
    } else {
    Get.toNamed(homeService!.route, arguments: homeService);
    }
    } else {
    BaseController().soonMessage();
    }


  }
}
