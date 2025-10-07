
import 'dart:io';

import 'package:get/get.dart';
import 'package:globcare/app/data/models/request_model.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/models/sleep_medicine_model.dart';
import '../../../data/repositories/appointment_requests_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../services/jitsi_meeting_service.dart';
import '../../../utils/launcher.dart';
import '../../appointment/appointment_controller.dart';
import '../../webview/webview_page.dart';

class SleepMedicineRequestsController extends BaseController {

  final AppointmentRequestsRepository appointmentRequestsRepository=AppointmentRequestsRepository();
  List<SleepMedicineModel> sleepMedicineRequests=[];
  final JitsiMeetingService jitsiMeetingService=JitsiMeetingService.instance;

  getSleepMedicineRequests()async{
    setBusy(true);

     sleepMedicineRequests= await appointmentRequestsRepository.getSleepMedicineRequests(id: AppointmentController.user!.id);
    setBusy(false);


  }

  @override
  void onInit() {


    getSleepMedicineRequests();

    super.onInit();
  }


  startMeeting(SleepMedicineModel sleepMedicine) async{




    await requestPermission();

    if(await Permission.microphone .request().isGranted  && await Permission.camera.request().isGranted) {

      jitsiMeetingService.join(meetingUrl: sleepMedicine.jitsiLink, subject: sleepMedicine.name, userDisplayName: currentUser!.name);


      // DifferentDialog.showJitsiAndroid14ImageHintDialog(onContinue: (){
      //   RequestModel requestModel=RequestModel();
      //   requestModel.name=sleepMedicine.name;
      //   requestModel.jitsiLink=sleepMedicine.jitsiLink;
      //   if(Platform.isAndroid) {
      //
      //
      //
      //     Get.to(() => WebviewPage(), arguments: requestModel);
      //   }
      //
      //   else{
      //
      //     Launcher.launchInBrowser(sleepMedicine.jitsiLink);
      //
      //   }
      //
      // });





    }
    else{
      buildFailedSnackBar(msg: AppStrings.microphoneCameraPermissionRequired.tr);

      await requestPermission();
    }


  }
  requestPermission()async{

    if(await Permission.camera.request().isGranted  )
    {

      return ;


    }
    else if(await Permission.camera.request().isPermanentlyDenied){
      await openAppSettings();

    }
    if(await Permission.microphone.request().isGranted  )
    {

      return ;


    }
    else if(await Permission.microphone.request().isPermanentlyDenied){
      await openAppSettings();

    }


  }

}
