import 'dart:async';
import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:globcare/app/utils/launcher.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../../base_controller/base_controller.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../data/constants/booking_constants.dart';
import '../../../../data/eunums/enums.dart';
import '../../../../data/models/request_model.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/repositories/appointment_repository.dart';
import '../../../../data/repositories/profile_repository.dart';
import '../../../../data/repositories/instant_consultation_repository.dart';
import '../../../../global_widgets/audio/asset_audio.dart';
import '../../../../global_widgets/shared/different_dialogs.dart';
import '../../../../routes/app_route_names.dart';
import '../../../../services/jitsi_meeting_service.dart';
import '../../../../services/push_notification_service.dart';
import '../../../../data/api/api_keys.dart';
import '../../../../core/assets_helper/app_images.dart';
import '../../../../data/api/app_urls.dart';
import '../../../qr_scanner/qr_scanner_logic.dart';
import '../../../webview/webview_page.dart';
import '../../appointment_base_controllers/booking_base_controller.dart';

class InstantConsultationStatesLogic extends BaseController
    with WidgetsBindingObserver {
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  final InstantConsultationRepository requestRepository = InstantConsultationRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  PushNotificationService pushNotificationService = PushNotificationService();
 final JitsiMeetingService jitsiMeetingService=JitsiMeetingService.instance;
  double price=0,vat=0;
  GetStorage box=GetStorage();
  List<AppUser> members = [];

  List<RequestModel> requests = [];
  static DateTime current1 = DateTime.now();

  static bool userInMeeting = false, meetingFinished = false, playTone = true;

  GlobalKey countDownKey = GlobalKey();
  String keyValue = '0';

  static String rate = '';

  Duration countDownDuration = Duration(minutes: 2, seconds: 0);

  static InstantConsultationStatus instantConsultationStatus =
      InstantConsultationStatus.load;

  DateTime alert = DateTime.now().add(Duration(seconds: 10));

///////////   meeting vars

  String room = '';
  bool? isAudioOnly = true;
  bool? isAudioMuted = true;
  bool? isVideoMuted = true;

  final subjectText = TextEditingController(text: "");
  final nameText = TextEditingController(text: "");
  final emailText = TextEditingController(text: "");
  final iosAppBarRGBAColor = TextEditingController(text: "#0080FF80");
  // static AppUser? selectedPatient;

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
    // selectedPatient = user;

    update();
  }

  // joinMeeting() async {
  //
  //
  //
  //
  //
  //   WakelockPlus.enable();
  //
  //
  //
  //
  //
  //
  //   var meetingUrl = currentRequest!.jitsiLink;
  //   room = (meetingUrl.substring(meetingUrl.lastIndexOf('/') + 1));
  //
  //   nameText.text = currentRequest!.patient;
  //   emailText.text = 'patient${currentUser!.id}@gmail.com';
  //   subjectText.text = currentRequest!.name;
  //
  //   //String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;
  //
  //   // Enable or disable any feature flag here
  //   // If feature flag are not provided, default values will be used
  //   // Full list of feature flags (and defaults) available in the README
  //   Map<FeatureFlag, Object> featureFlags = {
  //     FeatureFlag.isWelcomePageEnabled: false,
  //     FeatureFlag.isAddPeopleEnabled: false,
  //     FeatureFlag.isInviteEnabled: false,
  //     FeatureFlag.isRaiseHandEnabled: false,
  //     FeatureFlag.isMeetingPasswordEnabled: false,
  //     FeatureFlag.isLiveStreamingEnabled: false,
  //     FeatureFlag.isReplaceParticipantEnabled: false,
  //     FeatureFlag.isRecordingEnabled: false,
  //     FeatureFlag.isChatEnabled: true,
  //     // FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
  //     // FeatureFlagEnum.INVITE_ENABLED: false,
  //     // FeatureFlagEnum.RAISE_HAND_ENABLED: false,
  //     // FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
  //   };
  //
  //   logger.i('email: ${emailText.text}   name :${nameText.text }    subject :${subjectText.text}');
  //
  //
  //   // Define meetings options here
  //   var options = JitsiMeetingOptions(
  //     roomNameOrUrl: room,
  //     serverUrl: meetingUrl,
  //     subject: subjectText.text,
  //     // token: tokenText.text,
  //     isAudioMuted: false,
  //     isAudioOnly: false,
  //     isVideoMuted: false,
  //     userDisplayName: nameText.text,
  //     userEmail: emailText.text,
  //     featureFlags: featureFlags,
  //   );
  //
  //   await JitsiMeetWrapper.joinMeeting(
  //       options: options,
  //       listener: JitsiMeetingListener(
  //         onConferenceWillJoin: (message) {
  //           // debugPrint("${options.room} will join with message: $message");
  //         },
  //         onConferenceJoined: (message) {
  //           // debugPrint("${options.room} joined with message: $message");
  //         },
  //         onConferenceTerminated: (message, er) {
  //           WakelockPlus.disable();
  //
  //           // debugPrint("${options.room} terminated with message: $message");
  //         },
  //       ));
  // }


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






  ///////////////////

  updateStatus(InstantConsultationStatus s) {
    instantConsultationStatus = s;
    update();
  }

 Future updateFcmToken()async{

    String fcmToken=await PushNotificationService().getToken();
    Map<String, String> fcmData = {
      'id': currentUser!.id,
      'type':'1',
      'device_type':Platform.isAndroid?'android':'ios',
      'fcm_token':fcmToken,
    };
    await requestRepository.updateFcmToken(fcmData);
  }

  sendRequest() async {

// print("*************************  $price  ");

    if(price <=0){


      buildFailedSnackBar(title: AppStrings.oops.tr,msg: AppStrings.noAvailableDoctors.tr);

      return;

    }





    userInMeeting = false;






// print(fcmToken);
    Map<String, String> data = {
      'patient_id': currentUser!.id,
      'qr_code': QrScannerLogic.qrCtrl.text.toString().trim()
    };



    DifferentDialog.showProgressDialog();

    await updateFcmToken();

    var requests =
        await requestRepository.getRequestList(id: currentUser!.id);
    var allow =
        requests.where((element) => element.status.contains('waiting')).toList();

    if (allow.isEmpty) {
      var res = await requestRepository.createInstantCon(data);


      checkData(startTimer: true);


      Get.back();
      if (res != null) {
        if (res[ApiKeys.responseSuccess] == 1) {
          Get.back();

          QrScannerLogic.qrCtrl.clear();




          pushNotificationService.sendPushMessage(
            title: PushNotificationService.notificationTitle,
            body:
                '${PushNotificationService.notificationBody}  ${currentUser!.name} ',
            to: AppUrls.baseUrl == AppUrls.baseUrlProduction
                ? PushNotificationService.androidTopic
                : PushNotificationService.androidTopic,
            isTopic: true
          );
          pushNotificationService.sendPushMessage(
              title: PushNotificationService.notificationTitle,
              body:
                  '${PushNotificationService.notificationBody}  ${currentUser!.name} ',
              to: AppUrls.baseUrl == AppUrls.baseUrlProduction
                  ? PushNotificationService.iosTopic
                  : PushNotificationService.iosTopic,
              isIos: true,
          isTopic: true
          );



          consultationTimerFunc();
        } else {


          Get.back();
          buildFailedSnackBar(msg: res[ApiKeys.responseMessage]);
        }
      } else {
        buildFailedSnackBar(msg: AppStrings.thereIsProblem.tr);
      }
    } else {
      Get.back();

      buildFailedSnackBar(msg: AppStrings.alreadyHaveRequest.tr);
    }

    // soonMessage();
    // DifferentDialog.showProgressDialog();
    // var d=await Future.delayed(Duration(seconds: 2),);
    // Get.back();
    // updateStatus(InstantConsultationStatus.timer);
    // var dd=await Future.delayed(Duration(seconds: 5),);
    // updateStatus(InstantConsultationStatus.accepted);
  }

  sendTestNotification()async{

    pushNotificationService.sendPushMessage(
        title: PushNotificationService.notificationTitle,
        body:
        '${PushNotificationService.notificationBody}  ${currentUser!.name} ',
        to:  PushNotificationService.androidTopic,
        isTopic: true
    );

  }

  checkDiscountCode() async {


    if(QrScannerLogic.qrCtrl.text.toString().trim().isNotEmpty) {
      Map<String, String> data = {
        'qr_code': QrScannerLogic.qrCtrl.text.toString().trim()
      };


      DifferentDialog.showProgressDialog(msg: AppStrings.discountVerified.tr);


      var res = await requestRepository.checkDiscountCode(data);
// print(res);

      Get.back();

      if (res[ApiKeys.responseSuccess] == 1) {
        var data = res['data'];
        if (data['is_valid']) {
          buildSuccessSnackBar(
            title: '',
              msg: "${AppStrings.discountAvailableMsg.tr}\n${AppStrings
                  .discountAmount.tr} ${data['discount']}  ${AppStrings.currency.tr}",centered: true);
        }
        else {
          buildFailedSnackBar(msg: AppStrings.discountNotAvailableMsg.tr);
        }
      } else {
        buildFailedSnackBar(msg: res[ApiKeys.responseMessage]);
      }
    }
    else{
      buildFailedSnackBar(msg: AppStrings.discountCodeRequired.tr);

    }



  }

  timerFinished() async {
    if (DateTime.now().minute % 2 == 0) {
      updateStatus(InstantConsultationStatus.approved);
    } else {
      updateStatus(InstantConsultationStatus.resend);
    }
  }

  openPayment({
    bool applePay = false,
  }) async {



    double currentPrice = currentRequest!.price.toDouble() - currentRequest!.discount;
    // double currentPrice = currentRequest!.price.toDouble() - 8;
    if (!currentUser!.ssn.startsWith('1')) {
      vat = currentPrice * .15;
      //  BookingVars.price+= vat;
    }

    currentPrice += vat;
    price=currentPrice;

    price=double.parse(price.toStringAsFixed(2));


    // print(price);
    // return;

    BookingConstants.paymentFromInstantCons = true;
    DifferentDialog.showPaymentLoading();

     await BookingBaseController()
        .performtrxn(
            orderId: currentRequest!.id.toString(),
            failRoute: AppRouteNames.instantConsultation,
            requestModel: currentRequest,
            transType: Platform.isIOS && applePay ? 'applepay' : 'hosted',amount: price);
    onInit();

     // Get.back();
  }

  String formatDuration(Duration d) {
    String f(int n) {
      return n.toString().padLeft(2, '0');
    }

    // We want to round up the remaining time to the nearest second
    d += Duration(microseconds: 999999);
    return "${f(d.inMinutes)}:${f(d.inSeconds % 60)}";
  }

  @override
  void onClose() {

    WidgetsBinding.instance.removeObserver(this);

    super.onClose();


  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        {}
        // await player.play();
        break;
      case AppLifecycleState.inactive:
        {}
        //await player.stop();
        break;
      case AppLifecycleState.resumed:
        {
          instantConsultationStatus = InstantConsultationStatus.load;
          checkData();
        }
        //  await player.stop();
        break;
      case AppLifecycleState.detached:
        {}
        // await player.stop();
        // TODO: Handle this case.
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  List<String> statuses = [
    'waiting',
    'approved',
    'ready',
    'in_process',
    'evaluation'
  ];

  RequestModel? currentRequest;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    // selectedPatient=currentUser;
    instantConsultationStatus = InstantConsultationStatus.load;




    userInMeeting = false;

    WidgetsBinding.instance.addObserver(this);

    if(currentUser !=null) {


      checkData(startTimer: false);
    }
  }

  selectPatientClick() {
    if (currentUser != null) {
      InstantConsultationStatesLogic.instantConsultationStatus =
          InstantConsultationStatus.send;
      update();
      setBusy(true);
      checkData();
      setBusy(false);
    } else {
      buildFailedSnackBar(msg: AppStrings.selectPatientMsg.tr);
    }
  }

  bool isLoading = false;

  checkData( {startTimer=true} ) async {

    if(currentUser !=null) {
      // setBusy(true);
      isLoading = true;
      requests = await requestRepository.getRequestList(id: currentUser!.id);
      isLoading = false;

      currentRequest = requests.reversed
          .toList()
          .firstWhereOrNull((element) => statuses.contains(element.status));

      // print(currentRequest!.status);
      // setBusy(false);
      // if (AssetAudio.player.playing) {
      //   AssetAudio.player.stop();
      // }

      if (currentRequest == null) {
        // print('***************************   currentRequest=null  ');
        instantConsultationStatus = InstantConsultationStatus.send;
// setBusy(true);
        isLoading = true;

         price = await _appointmentRepository.getInstantConsPrice();
// setBusy(false);
        isLoading = false;
// print("****************   ${price}");
        // BookingConstants.price = (price);
      }
      else if (currentRequest!.status == statuses[0]) {
        // print('***************************   currentRequest=waiting  ');

        instantConsultationStatus = InstantConsultationStatus.timer;
        if (startTimer) {
          consultationTimerFunc();
        }
      }
      else if (currentRequest!.status == statuses[1]) {
        // var vat = 0.0;
        double currentPrice = currentRequest!.price.toDouble() - currentRequest!.discount;
        // double currentPrice = currentRequest!.price.toDouble() - 8;
        if (!currentUser!.ssn.startsWith('1')) {
          vat = currentPrice * .15;
          //  BookingVars.price+= vat;
        }

        currentPrice += vat;
        price=currentPrice;

        price=double.parse(price.toStringAsFixed(2));
        if (currentPrice == 0) {
          instantConsultationStatus = InstantConsultationStatus.load;
          update();
          var data = {
            ApiKeys.consultationId: currentRequest!.id.toString(),
            ApiKeys.paymentReference: 'Free',
            'deduction_amount': '0',
            'consultancy_price': '0',


          };

          // logger.i(' $data ');
          var res = await _appointmentRepository.setPaymentStatus(data,
              url: AppUrls.setPaymentStatusInstantCons);

          // logger.i(' $res ');


          if (currentRequest != null) {
            if (box.read(currentRequest!.name) == null) {
              pushNotificationService.sendPushMessage(
                  title: 'Consultation is ready',
                  body: '${currentRequest!
                      .patient} is wait you to start meeting',
                  to: currentRequest!.doctorToken,
                  isIos: currentRequest!.doctorDeviceType == 'ios');


              box.write(currentRequest!.name, true);
            }
          }

          checkData();
        } else {
          instantConsultationStatus = InstantConsultationStatus.approved;
        }
        if (startTimer) {
          consultationTimerFunc();
        }
      }
      else if (currentRequest!.status == statuses[4]) {
        instantConsultationStatus = InstantConsultationStatus.rating;
        if (startTimer) {
          consultationTimerFunc();
        }
      } else if (currentRequest!.status == statuses[2]) {
        // print('***************************   ready  ');

        instantConsultationStatus = InstantConsultationStatus.startMeeting;

        if (startTimer) {
          consultationTimerFunc();
        }
      }
      else if (currentRequest!.status == statuses[3]) {
        // print('***************************   in_process  ');

        instantConsultationStatus = InstantConsultationStatus.startMeeting;
        timerSound();


        if (startTimer) {
          consultationTimerFunc();
        }
      }

      // logger.i(instantConsultationStatus);
      update();
    }
  }

  consultationTimerFunc() {
    DateTime current = DateTime.now();
    Stream timer = Stream.periodic(Duration(seconds: 1), (i) {
      current = current.add(Duration(seconds: 1));
      return current;
    }).take(1000*60*60*24);

    timer.listen((data) {
      var d = data as DateTime;

      if (d.difference(current1).inSeconds % 10 == 0) {
        keyValue = 'key${d.difference(current1).inSeconds}';
        // print('   *************************  30');
        // print('   *************************  ${d.difference(current1).inSeconds}');

        if (!isLoading) {
          checkData();
        }
      }
    });
  }

  timerSound() {
    DateTime current = DateTime(2022, 1, 1, 1, 1, 1);
    DateTime current2 = DateTime(2022, 1, 1, 1, 1, 10);
    Stream timer = Stream.periodic(Duration(seconds: 1), (i) {
      current = current.add(Duration(seconds: 1));
      return current;
    }).take(10);

    timer.listen((data) {
      var d = data as DateTime;

      if (d.difference(current2).inSeconds == 0) {
        // print(
        //     'timer sound ******************  ${d.difference(current2).inSeconds}');

        if (AssetAudio.player.playing) {
          AssetAudio.player.stop();
        }
        playTone = false;
      }
    });
  }

  startMeeting() async{
    userInMeeting = true;
    if (AssetAudio.player.playing) {
      AssetAudio.player.stop();
    }

    // var appointment = Appointment(
    //     appointmentDate: DateTime.now(),
    //     doctor: currentRequest!.name,
    //
    //     videoLink: currentRequest!.jitsiLink);
    // //print(appointment.videoLink);
    //
    //  Get.toNamed(AppRouteNames.meetingPage,arguments: appointment);

await requestPermission();

if(await Permission.microphone .request().isGranted  && await Permission.camera.request().isGranted) {

      jitsiMeetingService.join(meetingUrl: currentRequest!.jitsiLink, subject: currentRequest!.name, userDisplayName: currentUser!.name);


  // DifferentDialog.showJitsiAndroid14ImageHintDialog(onContinue: (){
  //
  //   if(Platform.isAndroid) {
  //     Get.to(() => WebviewPage(), arguments: currentRequest);
  //   }
  //
  //   else{
  //
  //     Launcher.launchInBrowser(currentRequest!.jitsiLink);
  //
  //   }
  //
  // });



//   if(Platform.isAndroid){
//
//    DeviceInfoPlugin deviceInfoPlugin=DeviceInfoPlugin();
//
//    AndroidDeviceInfo android = await deviceInfoPlugin.androidInfo;
//
// // logger.i(android.version.sdkInt);
//
//    if(android.version.sdkInt >33){
//
//
//      DifferentDialog.showJitsiAndroid14ImageHintDialog(onContinue: (){
//
//        if(Platform.isAndroid) {
//          Get.to(() => WebviewPage(), arguments: currentRequest);
//        }
//
//        else{
//
//          Launcher.launchInBrowser(currentRequest!.jitsiLink);
//
//        }
//
//      });
//
//     // Get.to(()=>WebviewPage(),arguments: currentRequest);
//
//      // jitsiMeetingService.join(meetingUrl: currentRequest!.jitsiLink, subject: currentRequest!.name, userDisplayName: currentUser!.name);
//      // joinMeeting();
//
//    }
//    else{
//      // joinMeeting();
//      jitsiMeetingService.join(meetingUrl: currentRequest!.jitsiLink, subject: currentRequest!.name, userDisplayName: currentUser!.name);
//
//    }
//
//
//   }
//
//   else{
//
//     // joinMeeting();
//     // jitsiMeetingService.join(meetingUrl: currentRequest!.jitsiLink, subject: currentRequest!.name, userDisplayName: currentUser!.name);
//
//   }

}
else{
  buildFailedSnackBar(msg: AppStrings.microphoneCameraPermissionRequired.tr);

  await requestPermission();
}


  }

  onCounterDownDone() {
    DifferentDialog.showServiceInfoSnackBar(
        description: AppStrings.doctorsBusyNow.tr,
        title: '',
        image: AppImages.iconInstantCon);
    //buildFailedSnackBar(msg: AppStrings.doctorsBusyNow.tr);
    Future.delayed(Duration(seconds: 3), () {
      countDownKey = GlobalObjectKey(keyValue);
      update();
    });
  }

  rateConsultation() async {
    Map<String, String> data = {
      'consultation_id': currentRequest!.id.toString(),
      'evaluation': rate,
    };

    DifferentDialog.showThankMsgDialog();

    var result = await requestRepository.rateConsultation(data);
    // print(result);
    // buildSuccessSnackBar(msg: result);
    Get.back();

    if (result[ApiKeys.responseSuccess] == 1) {
      DifferentDialog.showThankMsgDialog();

      // checkData();
    }
  }




}
