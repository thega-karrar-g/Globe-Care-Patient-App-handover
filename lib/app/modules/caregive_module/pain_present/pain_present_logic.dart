import 'package:animated_custom_dropdown/custom_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../../data/models/pain_present.dart';
import '../../../data/repositories/caregiver_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../data/api/api_keys.dart';




class PainPresentLogic extends BaseController {


 final CaregiverRepository caregiverRepository=CaregiverRepository();


 static List<String> scores=  ['Mild','Moderate','Severe'];

  List<PainPresent> pains=[

    // PainPresent(score: scores[0],comment: 'test comment ', date: '2022-07-12 15:20:53'),
    // PainPresent(score: scores[1],comment: 'Free Download Pain 5 SVG vector file in monocolor and multicolor type for Sketch . ', date: '2022-07-12 15:20:53'),
    // PainPresent(score: scores[2],comment: 'test comment ', date: '2022-07-13 15:30:53'),
    // PainPresent(score: scores[1],comment: 'test comment ', date: '2022-07-13 15:20:53'),
    // PainPresent(score: scores[2],comment: 'test comment ', date: '2022-07-14 15:20:53'),
    // PainPresent(score: scores[0],comment: 'test comment ', date: '2022-07-14 15:20:53'),



  ];


 TextEditingController scoreCtrl = TextEditingController();
 TextEditingController commentCtrl = TextEditingController();
 TextEditingController scaleCtrl = TextEditingController();
 String scoreValue='',scaleValue='';
 List<Item> scoresList=[
   Item(id: 1,name: 'Mild'),
   Item(id: 2,name: 'Moderate'),
   Item(id: 3,name: 'Severe'),
 ];


 List<Item> scaleList=[
   Item(id: 1,name: 'Numerical'),
   Item(id: 2,name: 'Faces'),
   Item(id: 3,name: 'FLACC'),
   Item(id: 4,name: 'ABBEY'),
 ];

 resetTextCtrls() {
   scoreCtrl.clear();
   commentCtrl.clear();
   scaleCtrl.clear();

   update();
   //Get.back();

 }


 addPainPresent() async{


if(BaseController.recordId==0){

  buildFailedSnackBar(msg: 'Record is not found \ntry again');

}
else {

  if(scaleValue.isNotEmpty&&scoreValue.isNotEmpty) {


    DifferentDialog.showProgressDialog();

    var painPresent = PainPresent(recordId:BaseController. recordId.toString(),
        caregiverId: currentUser!.id,
        scale: scaleValue,
        score: scoreValue,
        comment: commentCtrl.text);

    //logger.i('********************  ${painPresent.toJson()}');

    var d = await caregiverRepository.addPainPresent(painPresent.toJson());

    Get.back();

if(d[ApiKeys.responseSuccess]==1){

  resetTextCtrls();


  print(Get.isBottomSheetOpen);

 await Future.delayed(Duration(milliseconds: 200),(){
    Get.back();

  });
  print(Get.isBottomSheetOpen);

  // Future.delayed(Duration(milliseconds: 200),(){
  //   Get.back();
  //
  // });


  buildSuccessSnackBar(msg: d[ApiKeys.responseMessage]);

  getPainPresent();

  // Get.offAllNamed(AppRouteNames.home);


}
else{
  buildFailedSnackBar(msg: d[ApiKeys.responseMessage]);
}

    logger.i('********************  $d');
  }

  else{
    buildFailedSnackBar(msg: 'Score and Scale used must not be empty');
  }

}


 }


 getPainPresent()async{



  if(BaseController.recordId !=0) {

  setBusy(true);
    pains = await caregiverRepository.getPainPresentList();
  setBusy(false);


  }


 }
 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getPainPresent();
  }

}
