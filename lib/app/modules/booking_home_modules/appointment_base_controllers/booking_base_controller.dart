import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:urwaypayment/urwaypayment.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/models/request_model.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../routes/app_route_names.dart';
import '../../../services/push_notification_service.dart';
import '../../../data/api/api_keys.dart';
import '../../../core/assets_helper/app_images.dart';
import '../nurse_services/nurse_services_logic.dart';
import '../patient_data/patient_data_logic.dart';

class BookingBaseController extends BaseController {
  PushNotificationService pushNotificationService=PushNotificationService();

  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  TextEditingController queryMerchantIdentifier = TextEditingController();

  createAppointment({bool applePay = false}) async {

    print("******************  from create : type ${BookingConstants.appointmentType}");

    BookingConstants.paymentFromInstantCons = false;

    Map<String, String> data = {
      ApiKeys.patientId: BookingConstants.patient!.id,
      ApiKeys.doctorId:
          '${BookingConstants.doctorId != 0 ? BookingConstants.doctorId : 1}',
      ApiKeys.appointmentDate:    DateFormat('yyyy-MM-dd').format((BookingConstants.appointmentDate)) ,
      ApiKeys.date:    DateFormat('yyyy-MM-dd').format((BookingConstants.appointmentDate)) ,
      // 'service_id':'10',
      ApiKeys.serviceId: '${BookingConstants.service.id}',
      if (BookingConstants.service2.id != 0)
        ApiKeys.serviceId2: '${BookingConstants.service2.id}',
      if (BookingConstants.service3.id != 0)
        ApiKeys.serviceId3: '${BookingConstants.service3.id}',

      if (BookingConstants.discountId != 0)

        ApiKeys.discountId: '${BookingConstants.discountId}',


      if (BookingConstants.branch != null)

        ApiKeys.branch: BookingConstants.branch!,

      ApiKeys.formType: BookingConstants.serviceType,

      ApiKeys.location: BookingConstants.location,
      //ApiKeys.consultancyType:BookingVars.consultancyType,
      ApiKeys.consultancyPrice: '${BookingConstants.price}',
      ApiKeys.period:BookingConstants.period.isNotEmpty? BookingConstants.period.toLowerCase():"morning",
      ApiKeys.hour: BookingConstants.hour.toLowerCase().split(':')[0].trim(),
      ApiKeys.time: DateFormat('HH:mm').format((BookingConstants.appointmentDate)),
      ApiKeys.gender: BookingConstants.doctorGender,
      ApiKeys.patientFollowers: BookingConstants.patientFollowers,
      ApiKeys.patientComment: BookingConstants.patientComment.text.toString(),
      //'payment_type':BookingVars.paymentType
      ApiKeys.paymentType: ApiKeys.payValue,
      ApiKeys.paymentMadeThrough: 'mobile',
      ApiKeys.noCaregiver: '1',

    if (Get.isRegistered<NurseServicesLogic>() && Get.find<NurseServicesLogic>().homeService.code == 'Car')


      ///  CTF  mean Caregiver Transporting Fee
      ApiKeys.additionalService: BookingConstants.transportingFee >0 ? 'CTF' :"",


      'app_version': '1'
    };

    // print(json.encode(data));

    // logger.i('*****************       $data   *************************');
    try {
      setBusy(true);

      Map<String,File> files={

        if(BookingConstants.audioFile !=null)
          ApiKeys.attachedFile:BookingConstants.audioFile!,
        if(BookingConstants.attachFile !=null)
          ApiKeys.attachedFile2:BookingConstants.attachFile!,

        if(BookingConstants.cameraFile !=null)
          ApiKeys.attachedFile3:BookingConstants.cameraFile!,


      };

      DifferentDialog.showProgressDialog();
      var result = await _appointmentRepository.createAppointment(data,files: files);


      // logger.i('******** reslt:  $result ');

      // buildSuccessSnackBar(msg: result);
      Get.back();

      var jsonData = (result);
      var msg = '';
      var success = jsonData[ApiKeys.responseSuccess] as int;

      if (success == 1) {
        var id = '${jsonData![ApiKeys.responseData]['id']}';

        BookingConstants.audioFile = null;
        BookingConstants.attachFile = null;
        BookingConstants.cameraFile = null;
        BookingConstants.serviceCode = '';
        BookingConstants.service2.id = 0;
        BookingConstants.service3.id = 0;
        BookingConstants.patientComment.clear();



        // if(BookingVars.percentDiscount>0){
        //
        //
        //    BookingVars.price=(BookingVars.price - ((BookingVars.price-BookingVars.vat ) *BookingVars.percentDiscount/100));
        // }

       // logger.i("***************************    price before payment ${BookingConstants.price}  ********************   ");

        if (Platform.isIOS && applePay) {
          performtrxn(transType: 'applepay', orderId: id,amount:  BookingConstants.price);
        } else {
          DifferentDialog.showPaymentLoading();

          performtrxn(orderId: id,amount:  BookingConstants.price);
        }
      } else {
        msg = '${jsonData[ApiKeys.responseMessage]}';
        buildFailedSnackBar(msg: msg);
      }

      setBusy(false);
    } catch (er) {

      setBusy(false);
    }
  }




  requestCareGiver(Map<String, String> data) async {
    // try {
    DifferentDialog.showProgressDialog();

    // print(data);
    var result = await _appointmentRepository.createAppointment(data);

    // print(result);
    // buildSuccessSnackBar(msg: result);
    Get.back();

    var jsonData = (result);

    var msg = '';
    var success = jsonData[ApiKeys.responseSuccess] as int;

    if (success == 1) {
      msg = '${jsonData![ApiKeys.responseData][ApiKeys.responseMessage]}';

      BookingConstants.audioFile = null;
      BookingConstants.serviceCode = '';
      BookingConstants.service2.id = 0;
      BookingConstants.service3.id = 0;
      DifferentDialog.showRequestServiceSuccessDialog(
          msg: AppStrings.appointmentSendSuccess);
    } else {
      msg = '${jsonData[ApiKeys.responseMessage]}';
      buildFailedSnackBar(msg: AppStrings.errorMsg.tr);
    }

    // }
    // catch(_){
    // }
  }

  requestCancelAppointment(Map<String, String> data) async {

logger.i(data);
    try {
    DifferentDialog.showProgressDialog();
    var result = await _appointmentRepository.requestCancelAppointment(data);
    logger.i(result);
    Get.back();

    var jsonData = (result);

    var msg = '';
    var success = jsonData[ApiKeys.responseSuccess] as int;

    if (success == 1) {
      DifferentDialog.showRequestServiceSuccessDialog(
          msg: AppStrings.appointmentCancelRequestSuccess);
    } else {
      msg = '${jsonData[ApiKeys.responseMessage]}';
      buildFailedSnackBar(msg: msg);
    }

    }
    catch(_){
    }
  }

  cancelAppointment(String appointmentId,
      {String route = AppRouteNames.homeTabs}) async
  {
    var data = {
      ApiKeys.appointmentType:
          BookingConstants.paymentAppointmentType.toString().split('.')[1],
      ApiKeys.appointmentId: appointmentId,
      ApiKeys.paymentReference: '0',
      ApiKeys.consultancyPrice: -1,
      'deduction_amount':-1
    };

    logger.i("data $data");
     DifferentDialog.showProgressDialog();
  var res=  await _appointmentRepository.setPaymentStatus(data);
    DifferentDialog.hideProgressDialog();

  logger.i("res $res");

    if (route == AppRouteNames.homeTabs) {
      Get.offAllNamed(AppRouteNames.homeTabs);
    } else {
      Get.toNamed(route);
    }

  }

  Future<void> performtrxn(
      {
       required double amount,

        String transType = 'hosted',
      String orderId = '0',
      String redirectPage = AppRouteNames.receiptPage,
      String failRoute = AppRouteNames.invoicePage,
      RequestModel? requestModel}) async
  {


    var udf = 'https://glob-care.com/';

    queryMerchantIdentifier.text = "merchant.com.globcare.app";

    var lastResult = "";
    var act = '1';
    var carOper = '';
    var tokenTy = '1';
    if (transType == "hosted")
    {
      // on Apple Click call other method  check with if else
      lastResult = await Payment.makepaymentService(
          context: Get.context!,
          country: 'SA',
          action: act,
          currency: 'SAR',
          //   amt: '100.0',
          amt:amount.toString(),
          customerEmail: 'info@glob-care.com',
          trackid: orderId,
          udf1: udf,
          // udf2: 'https://glob-care.com/',
          udf2: 'https://glob-care.com/test.html',
          udf3: Get.locale.toString(),
          udf4: '',
          udf5: '',
          cardToken: '',
          address: '',
          city: '',
          state: '',
          tokenizationType: tokenTy,
          zipCode: '',
          tokenOperation: carOper,
          onBack: () {
            DifferentDialog.showBackPaymentDialog(onCancel: () {
              cancelAppointment(orderId);
            });
          },
          title: AppStrings.paymentDetails.tr,
          ar: Get.locale.toString() == 'ar',
          appBar: Transform(
            transform:
                Matrix4.rotationY(Get.locale.toString() == 'ar' ? math.pi : 0),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppImages.back,
              // fit: BoxFit.fill,
              //    width: 50,height:80,
              // colorBlendMode: BlendMode.color,
            ),
          ));

      print('Result in Main is $lastResult');
    } else if (transType == "applepay") {
      print("In apple pay");
      lastResult = await Payment.makeapplepaypaymentService(
        context: Get.context!,
        country: 'SA',
        action: act,
        currency: 'SAR',
        //   amt: '100.0',
        amt: amount.toString(),
        customerEmail: 'info@glob-care.com',
        trackid: orderId,
        udf1: udf,
        // udf2: 'https://glob-care.com/',
        udf2: 'https://glob-care.com/test.html',
        udf3: Get.locale.toString(),
        udf4: '',
        udf5: '',
        tokenizationType: tokenTy,
        merchantIdentifier: queryMerchantIdentifier.text,
        shippingCharge: '0.0',
        companyName: 'globcare',
      );
      print('Result on Apple Pay in Main is $lastResult');
    }

// if (xyz != null )
//    {h
//      lastResult=xyz;

    logger.i("***   lastResult ***** \n$lastResult   \n");

    Map<String, dynamic> decodedJSON;
    var decodeSucceeded = false;
    try {
      decodedJSON = json.decode(lastResult) as Map<String, dynamic>;
      decodeSucceeded = true;
    } on FormatException catch (e) {

      buildFailedSnackBar(msg: AppStrings.paymentFailed.tr);
      print('${e.message.toString()} The provided string is not valid JSON');

     // return;

    }
    if (decodeSucceeded) {
      var responseData = json.decode(lastResult);
      // print('RESP $responseData');
      var trnsId = responseData["TranId"] as String;
      var respCode = responseData["ResponseCode"] as String;
      var amount = responseData["amount"] as String;
      var cardBrand = responseData["cardBrand"] as String;
      var result = responseData["result"] as String;




      if(respCode !='000'){


        buildFailedSnackBar(msg: respCode);
       // return;
      }


      if(BookingConstants.paymentFromInstantCons&&respCode=='000'){
        if(requestModel!=null) {
          pushNotificationService.sendPushMessage(title: 'Consultation is ready',body: '${requestModel.patient} is wait you to start meeting',to:requestModel.doctorToken,isIos: requestModel.doctorDeviceType=='ios' );
        }

      }





if(respCode=='000'){



  bool  isSleepOrCaregiver=[ChooseDateType.sleepMedicine,ChooseDateType.caregiver].contains(PatientDataLogic.chooseDateType);


  String msg=AppStrings.paymentSuccess.tr;

  if(isSleepOrCaregiver){
    msg +=' ${AppStrings.willContactASAP.tr}';

  }

  buildSuccessSnackBar(msg: msg);



}else{


  buildFailedSnackBar(msg: AppStrings.paymentFailed.tr);

}

      if(respCode !='000'  && !BookingConstants.paymentFromInstantCons){

      //  cancelAppointment(orderId);
      }

      else {
        var data = {
          'transId': trnsId,
          'respCode': respCode,
          'amount': amount,
          'orderId': orderId,
          'cardBrand': cardBrand,
          'failRoute': failRoute,

        };
        Get.toNamed(redirectPage, arguments: data);
      }
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReceiptPage(trnsid,result,amount,cardToken,respCode)));
    }
    else {
      if (lastResult.isNotEmpty) {
        print('Show');
               }
      else {
        print('Show Blank Data');
        buildFailedSnackBar(msg: AppStrings.paymentFailed.tr);

        cancelAppointment(orderId);

      }
    }
    print('Payment $lastResult');
  }



  // String getRandString(int len) {
  //   var random = Random.secure();
  //   var values = random.nextInt(10000000);
  //   // return base64UrlEncode(values);
  //   return values.toString();
  // }
}
