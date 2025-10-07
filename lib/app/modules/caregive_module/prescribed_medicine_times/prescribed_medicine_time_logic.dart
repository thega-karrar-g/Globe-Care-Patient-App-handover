
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/prescribed_medicine.dart';
import '../../../data/repositories/caregiver_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';




class PrescribedMedicineTimeLogic extends BaseController {

  CaregiverRepository caregiverRepository=CaregiverRepository();


  TextEditingController reasonCtrl=TextEditingController();

  String medicineStatus='wait';
  List<String> states=['wait','given','canceled','missed'];

  List<PrescribedMedicine> currentMedicines=[];
  List<PrescribedMedicineGroup> medicinesGroup=[];
  List<PrescribedMedicine> allMedicines=[



  ];


  PrescribedMedicine medicine=Get.arguments;





  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

getData();



    // updateMedicineStatus(states[0]);
  }


  updateStatus(String id ,{String state='given'})async{

DifferentDialog.showProgressDialog();
  var response=await  caregiverRepository.updateMedicineStatus({'slot_id':id,'caregiver':currentUser!.id,'state':state,'comment':reasonCtrl.text});
Get.back();

  Get.back();
  reasonCtrl.clear();
  getData();
  logger.i(response);


  }


  getData()async{
    setBusy(true);
    currentMedicines =await caregiverRepository.getPrescribedMedicineTimesList(medicineId: medicine.id.toString());

      medicinesGroup=groupItemsByData(currentMedicines).where((element) => element.dateTime.difference(DateTime.now()).inDays>-1 ).toList();
        setBusy(false);
   // setNotification(currentMedicines);
  }

  List< PrescribedMedicineGroup> groupItemsByData(List<PrescribedMedicine> items) {
    final groups = groupBy(items, (PrescribedMedicine e) {
      return DateTime.parse(e.date);
    });
    medicinesGroup.clear();
    groups.forEach((key, value) {

      medicinesGroup.add(PrescribedMedicineGroup(dateTime: key,items: value));

    });
    var sort= medicinesGroup.sort((a, b) => a.dateTime .compareTo((b.dateTime),));

    return  medicinesGroup;
  }





// registerTask(PrescribedMedicine med,DateTime dt,String title,String body){
//   var left=DateTime.now().difference(dt).inMinutes;
//
// //print("left **********************   $left");
//
//
//   Workmanager().registerOneOffTask("task-identifier${med.id}", "${med.id}",
//
//     initialDelay: Duration(minutes: (left )*-1),
//     backoffPolicyDelay: Duration(minutes: (left )*-1),
//    // backoffPolicyDelay: Duration(minutes: DateTime.now().difference(dt).inMinutes),
//
//     inputData: {'id':med.id,'title':title,'body':body},
//       existingWorkPolicy: ExistingWorkPolicy.replace
//       // constraints: Constraints(
//       //     networkType: NetworkType.connected,
//       //     requiresBatteryNotLow: true,
//       //     requiresCharging: true,
//       //     requiresDeviceIdle: true,
//       //     requiresStorageNotLow: true
//       // )
//
//   );
//
//
// }

  String dateConverter(DateTime myDate) {
    String date='Today';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    final dateToCheck = myDate;
    final checkDate = DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (checkDate == today) {
      date = AppStrings.today;
    }
    else if (checkDate == yesterday) {
      date = AppStrings.yesterday;
    }
    else if (checkDate == tomorrow) {
      date = AppStrings.tomorrow;
    }
    else {
      date = DateFormat("d MMM yyyy",Get.locale.toString()).format(myDate);
    }
    return date;
  }

}
