import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:urwaypayment/urwaypayment.dart';

import '../base_controller/helpers_methods.dart';

import '../core/assets_helper/app_images.dart';
import '../core/language_and_localization/app_strings.dart';
import '../global_widgets/shared/different_dialogs.dart';

class PaymentService  with HelpersMethod{


  PaymentService._();


  static final PaymentService _instance = PaymentService._();

  static PaymentService get instance => _instance;


  Future<bool> performtrxn(
      {String transType = 'hosted',
        String orderId = '0',
        double amount=0.0,
        // String redirectPage = AppRouteNames.receiptPage,
        // String failRoute = AppRouteNames.invoicePage,
        // RequestModel? requestModel
      }) async
  {
    var udf = 'https://glob-care.com/';

    String merchantIdentifier = "merchant.com.globcare.app";

    var lastResult = "";
    var act = '1';
    var carOper = '';
    var tokenTy = '1';
    if (transType == "hosted") {
      // on Apple Click call other method  check with if else



      lastResult = await Payment.makepaymentService(
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
          cardToken: '',
          address: '',
          city: '',
          state: '',
          tokenizationType: tokenTy,
          zipCode: '',
          tokenOperation: carOper,
          onBack: () {
            DifferentDialog.showBackPaymentDialog(onCancel: () {
              //  cancelAppointment(orderId);
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
        merchantIdentifier: merchantIdentifier,
        shippingCharge: '0.0',
        companyName: 'globcare',
      );
      print('Result on Apple Pay in Main is $lastResult');
    }

// if (xyz != null )
//    {h
//      lastResult=xyz;

    log("***   lastResult ***** \n$lastResult   \n");
    Map<String, dynamic> decodedJSON;
    var decodeSucceeded = false;
    try {
      decodedJSON = json.decode(lastResult) as Map<String, dynamic>;
      decodeSucceeded = true;
    } on FormatException catch (e) {
      buildFailedSnackBar(msg: AppStrings.paymentFailed.tr);
      print('${e.message.toString()} The provided string is not valid JSON');

      return false;

    }
    if (decodeSucceeded) {
      var responseData = json.decode(lastResult);
      // print('RESP $responseData');
      var trnsId = responseData["TranId"] as String;
      var respCode = responseData["ResponseCode"] as String;
      var amount = responseData["amount"] as String;
      var cardBrand = responseData["cardBrand"] as String;
      var result = responseData["result"] as String;


      if (respCode != '000') {
        //  buildFailedSnackBar(msg: respCode);
        return false;
      }

      return true;
      //
      //   if(BookingConstants.paymentFromInstantCons&&respCode=='000'){
      //     if(requestModel!=null) {
      //       pushNotificationService.sendPushMessage(title: 'Consultation is ready',body: '${requestModel.patient} is wait you to start meeting',to:requestModel.doctorToken,isIos: requestModel.doctorDeviceType=='ios' );
      //     }
      //
      //   }
      //
      //
      //
      //
      //
      //   if(respCode=='000'){
      //
      //
      //
      //     bool  isSleepOrCaregiver=[ChooseDateType.sleepMedicine,ChooseDateType.caregiver].contains(PatientDataLogic.chooseDateType);
      //
      //
      //     String msg=AppStrings.paymentSuccess.tr;
      //
      //     if(isSleepOrCaregiver){
      //       msg +=' ${AppStrings.willContactASAP.tr}';
      //
      //     }
      //
      //     buildSuccessSnackBar(msg: msg);
      //
      //
      //
      //   }
      //   else{
      //
      //
      //     buildFailedSnackBar(msg: AppStrings.paymentFailed.tr);
      //
      //   }
      //
      //   if(respCode !='000'  && !BookingConstants.paymentFromInstantCons){
      //
      //     cancelAppointment(orderId);
      //   }
      //
      //   else {
      //     var data = {
      //       'transId': trnsId,
      //       'respCode': respCode,
      //       'amount': amount,
      //       'orderId': orderId,
      //       'cardBrand': cardBrand,
      //       'failRoute': failRoute,
      //
      //     };
      //     Get.toNamed(redirectPage, arguments: data);
      //   }
      //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReceiptPage(trnsid,result,amount,cardToken,respCode)));
      // } else {
      //   if (lastResult.isNotEmpty) {
      //     print('Show');
      //   } else {
      //     print('Show Blank Data');
      //     cancelAppointment(orderId);
      //
      //   }
      // }
      print('Payment $lastResult');
    }
  }
}