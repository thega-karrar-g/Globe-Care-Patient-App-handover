

import 'dart:io';

import 'package:get/get.dart';
import 'package:globcare/app/data/models/file_model.dart';
import 'package:globcare/app/modules/appointment/appointment_controller.dart';
import 'package:globcare/app/utils/download_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api/api_keys.dart';
import '../../../data/models/caregiver_contract_model.dart';
import '../../../data/models/request_model.dart';
import '../../../data/repositories/appointment_requests_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../services/jitsi_meeting_service.dart';
import '../../../utils/ext_storage.dart';
import '../../../utils/launcher.dart';
import '../../webview/webview_page.dart';

class CaregiverContractRequestsController extends BaseController {

  final AppointmentRequestsRepository appointmentRequestsRepository=AppointmentRequestsRepository();
  List<CaregiverContractModel> caregiverContractRequests=[];
  final JitsiMeetingService jitsiMeetingService=JitsiMeetingService.instance;

  getCaregiverContractRequests()async{
    setBusy(true);

    caregiverContractRequests= await appointmentRequestsRepository.getCaregiverContractRequests(id: AppointmentController.user!.id );
    //print(caregiverContractRequests.length);
    setBusy(false);


  }

  @override
  void onInit() {


    getCaregiverContractRequests();

    super.onInit();
  }


  startMeeting(CaregiverContractModel caregiverContract) async{




    await requestPermission();

    if(await Permission.microphone .request().isGranted  && await Permission.camera.request().isGranted) {

      jitsiMeetingService.join(meetingUrl: caregiverContract.jitsiLink, subject: caregiverContract.name, userDisplayName: currentUser!.name);


      // DifferentDialog.showJitsiAndroid14ImageHintDialog(onContinue: (){
      //   RequestModel requestModel=RequestModel();
      //   requestModel.name=caregiverContract.name;
      //   requestModel.jitsiLink=caregiverContract.jitsiLink;
      //   if(Platform.isAndroid) {
      //
      //
      //
      //     Get.to(() => WebviewPage(), arguments: requestModel);
      //   }
      //
      //   else{
      //
      //     Launcher.launchInBrowser(caregiverContract.jitsiLink);
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


  updateCaregiverContract(int id,String state)async{


    DifferentDialog.showProgressDialog();
    var data={"id":id,"state":state};

    var result=await  appointmentRequestsRepository.updateCaregiverContract(data);

    DifferentDialog.hideProgressDialog();
    print(result);

    if(result[ApiKeys.responseSuccess]==1){
Get.back();
getCaregiverContractRequests();

    }


  }


  onTabFileContract(CaregiverContractModel caregiverContract)async{

    final String ext = '.pdf';

    FileModel file=FileModel(
      name: caregiverContract.id.toString(),
      // link: "http://20.216.57.38:8069/web/attachments/token/4f0c180e-936a-467b-af9b-4da03e884a6d",
      link: caregiverContract.pdfLink,


    );

    if (await ExtStorage.fileExist(file.name+ext)) {
      ExtStorage.openFile(file.name + ext);
    } else {
      if (file.link.isNotEmpty) {


        var res = false;
        res = await DifferentDialog.showProgressDownloadDialog(
            file: file, );
        if (await ExtStorage.fileExist(file.name+ext)) {
          ExtStorage.openFile(file.name + ext);
        }
        if (res == true) {
          update();
          res = false;
        }
      } else {
        BaseController().buildFailedSnackBar(
            msg: AppStrings.fileNotReady.tr);
      }
    }


  }

}
