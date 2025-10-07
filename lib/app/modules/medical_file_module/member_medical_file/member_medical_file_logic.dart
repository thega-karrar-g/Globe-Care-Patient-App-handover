import 'package:get/get.dart';
import 'package:globcare/app/base_controller/base_controller.dart';

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/home_service.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_route_names.dart';
import '../../../utils/ext_storage.dart';
import '../../select_patient/select_patient_logic.dart';

class MemberMedicalFileLogic extends BaseController {
  List<HomeService> services = [
    HomeService(
        id: 1,
        name: AppStrings.prescriptionList,
        icon: AppImages.iconMedicineList,
        route: AppRouteNames.radiologyLabFiles,
        code: 'P',
        primary: true,
        user: Get.arguments),
    HomeService(
        id: 1,
        name: AppStrings.labTests,
        icon: AppImages.iconLab,
        route: AppRouteNames.radiologyLabFiles,
        primary: true,
        code: 'L',
        user: Get.arguments),
    HomeService(
        id: 1,
        name: AppStrings.medFileReport,
        icon: AppImages.iconMedicalReport,
        route: AppRouteNames.radiologyLabFiles,
        code: 'R',
        primary: true,
        user: Get.arguments),
    HomeService(
        id: 1,
        name: AppStrings.medFileImageTest,
        icon: AppImages.iconXRay,
        route: AppRouteNames.radiologyLabFiles,
        primary: true,
        code: 'X',
        user: Get.arguments),
  ];

  var userId = '';
  AppUser user = Get.arguments;


  void onTabItem(HomeService homeService,{bool isMedicalFile =false}) async{


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
          buildFailedSnackBar(msg: AppStrings.selectPatientMsg.tr);
        }
      }
      else {
        Get.toNamed(homeService.route, arguments: homeService);
      }
    } else {
      soonMessage();
    }


  }


}
