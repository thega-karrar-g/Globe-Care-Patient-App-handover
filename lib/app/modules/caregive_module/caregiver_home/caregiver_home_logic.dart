import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/home_service.dart';
import '../../../data/models/record_model.dart';
import '../../../data/repositories/caregiver_repository.dart';
import '../../../routes/app_route_names.dart';
import '../../../utils/ext_storage.dart';
import '../../select_patient/select_patient_logic.dart';
import '../observation/observation_view.dart';
import '../pain_present/pain_present_view.dart';
import '../prescribed_medicine/prescribed_medicine_view.dart';
import '../vital_signs/vital_signs_view.dart';

class CaregiverHomeLogic extends BaseController {
  RecordModel? patientRecord;

  final CaregiverRepository caregiverRepository=CaregiverRepository();

  int index=0;


  var user = (Get.arguments as HomeService).user!;

  updateIndex(int i){

    print(i);
    index=i;
    update();
  }

  List<HomeService>  services=[

     HomeService(id: 1,name: AppStrings.prescribedMedicine,icon: AppImages.iconMedicineList,route: PrescribedMedicinePage.routeName,primary: true,code: 'R',),
    HomeService(id: 1,name: AppStrings.vitalSigns,icon: AppImages.vitalSignsIcon,route: VitalSignsPage.routeName,primary: true,code: 'P',),
    HomeService(id: 1,name: AppStrings.painPresent,icon: AppImages.painPresent,route: PainPresentPage.routeName,primary: true,code: 'L',),
    HomeService(id: 1,name: AppStrings.observation,icon: AppImages.observation,route:ObservationPage.routeName,primary: true,code: 'X',),

  ];



  getRecordFile()async{

    // print(currentUser!.toMap());


    setBusy(true);
    patientRecord=await  caregiverRepository.getRecordFile(user.id);


    print(patientRecord);
    if(patientRecord !=null) {
      print(patientRecord!.toJson());

      BaseController. recordId=patientRecord!.id;

    }

    setBusy(false);




  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRecordFile();
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
