import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../../data/models/vital_signs.dart';
import '../../../data/repositories/caregiver_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../data/api/api_keys.dart';




class VitalSignsLogic extends BaseController {

 final CaregiverRepository caregiverRepository=CaregiverRepository();


 String stateValue='';
 List<Item> stateList=[
   Item(id: 1,name: 'at room air'),
   Item(id: 2,name: 'with oxygen Support'),
 ];


  List<VitalSigns> vitalSigns=[

    // VitalSigns(weight: '70',oxygenSaturation: '20',temperature: '37',bloodPressureSys: '120/80',bloodSugar: '93',heartRate: '77',respiration: '80',date: '2022-07-12 15:20:53'),
    // VitalSigns(weight: '90',oxygenSaturation: '20',temperature: '37',bloodPressureSys: '120/80',bloodSugar: '93',heartRate: '77',respiration: '80',date: '2022-07-13 15:20:53'),
    // VitalSigns(weight: '30',oxygenSaturation: '20',temperature: '37',bloodPressureSys: '120/80',bloodSugar: '93',heartRate: '77',respiration: '80',date: '2022-07-13 20:20:53'),
    // VitalSigns(weight: '50',oxygenSaturation: '20',temperature: '37',bloodPressureSys: '120/80',bloodSugar: '93',heartRate: '77',respiration: '80',date: '2022-07-14 15:20:53'),
    // VitalSigns(weight: '40',oxygenSaturation: '20',temperature: '37',bloodPressureSys: '120/80',bloodSugar: '93',heartRate: '77',respiration: '80',date: '2022-07-14 19:20:53'),
    // VitalSigns(weight: '40',oxygenSaturation: '20',temperature: '37',bloodPressureSys: '120/80',bloodSugar: '93',heartRate: '77',respiration: '80',date: '2022-07-15 15:20:53'),
    //


  ];


  /////////// vital signs
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController oxygenSaturationCtrl = TextEditingController();
  TextEditingController oxygenSaturationStateCtrl = TextEditingController();
  TextEditingController temperatureCtrl = TextEditingController();
  TextEditingController bloodPressureDCtrl = TextEditingController();
  TextEditingController bloodPressureSCtrl = TextEditingController();
  TextEditingController bloodSugarCtrl = TextEditingController();
  TextEditingController heartRateCtrl = TextEditingController();
  TextEditingController respirationCtrl = TextEditingController();


  resetVitalSign() {
    weightCtrl.clear();
    temperatureCtrl.clear();
    bloodSugarCtrl.clear();
    bloodPressureSCtrl.clear();
    bloodPressureDCtrl.clear();
    heartRateCtrl.clear();
    oxygenSaturationCtrl.clear();
    oxygenSaturationStateCtrl.clear();
    respirationCtrl.clear();
    update();
   // Get.back();

  }



  getVitalList()async{





    if(BaseController.recordId !=0) {

      setBusy(true);

      vitalSigns = await caregiverRepository.getVitalList();
      setBusy(false);

    }



  }


  addVital()async{

    DifferentDialog.showProgressDialog();

    VitalSigns v=VitalSigns(caregiverId: currentUser!.id,recordId: BaseController.recordId.toString(),

      temperature: temperatureCtrl.text,
      bloodPressureSys: bloodPressureSCtrl.text,
      bloodPressureDia: bloodPressureDCtrl.text,
      heartRate: heartRateCtrl.text,
      oxygenSaturation: oxygenSaturationCtrl.text,
      respiration: respirationCtrl.text,
      oxygenSaturationStatus: oxygenSaturationStateCtrl.text,
      bloodSugar: bloodSugarCtrl.text,



    );

   // logger.i("***************************   ${v.toJson()}");
  var d=await  caregiverRepository.addVital(v.toJson());





    Get.back();

    if(d[ApiKeys.responseSuccess]==1){


      resetVitalSign();


      Future.delayed(Duration(milliseconds: 200),(){
        Get.back();

      });




       buildSuccessSnackBar(msg: d[ApiKeys.responseMessage]);

      // Get.back();


      getVitalList();

    //  Get.offAllNamed(AppRouteNames.home);


    }
    else{
      buildFailedSnackBar(msg: d[ApiKeys.responseMessage]);
    }


  logger.i(" $d");



  }




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getVitalList();
  }

}
