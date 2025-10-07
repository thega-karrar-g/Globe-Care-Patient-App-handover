import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../../data/models/observation.dart';
import '../../../data/models/observation_task.dart';
import '../../../data/repositories/caregiver_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../data/api/api_keys.dart';




class ObservationLogic extends BaseController {

  bool expanded=false;
  final CaregiverRepository caregiverRepository=CaregiverRepository();



static List<String> states2=['Excellent','Good','Fair','Poor'];


TextEditingController sleepingPatternCtrl = TextEditingController();
TextEditingController nutritionalStatusCtrl = TextEditingController();
TextEditingController progressNotedCtrl = TextEditingController();






String nutritionalStatusValue='',sleepingPatternValue='';
List<Item> statesList=[
  Item(id: 1,name: 'Excellent'),
  Item(id: 2,name: 'Good'),
  Item(id: 3,name: 'Fair'),
  Item(id: 4,name: 'Poor'),
];


  List<Item> taskStatesList=[
    Item(id: 1,name: 'Done'),
    Item(id: 2,name: 'Not Done'),
    Item(id: 3,name: 'NA'),
  ];


resetTextCtrl() {
  nutritionalStatusCtrl.clear();
  sleepingPatternCtrl.clear();
  progressNotedCtrl.clear();

  update();
 // Get.back();

}



  List<Observation> observations=[





  ];


  Map<String, dynamic> toJson() {

    var map= {
      "record_id":BaseController.recordId.toString(),
      "nutritional_status": nutritionalStatusCtrl.text,
      "sleeping_pattern": sleepingPatternCtrl.text,
      "progress_noted": progressNotedCtrl.text,

    };
    for (var e in ObservationTask.tasks) {

      map.addAll({e.key:e.dropdownCtrl!.text,e.textKey:e.reasonCtrl!.text});

    }


  return  map;
  }


updateExpanded(bool expanded)
{

  expanded=expanded;
  update();
}




  getObservationList()async{





    if(BaseController.recordId !=0) {

      setBusy(true);

      observations = await caregiverRepository.getObservationList();
      setBusy(false);

    }



  }


  addObservation()async{

    DifferentDialog.showProgressDialog();


    var d=await  caregiverRepository.addObservation(toJson());





    Get.back();

    if(d[ApiKeys.responseSuccess]==1){


      Future.delayed(Duration(milliseconds: 200),(){
        Get.back();

      });

      resetTextCtrl();

      buildSuccessSnackBar(msg: d[ApiKeys.responseMessage]);


      getObservationList();

      // Get.offAllNamed(AppRouteNames.home);


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


    getObservationList();
  }

}
