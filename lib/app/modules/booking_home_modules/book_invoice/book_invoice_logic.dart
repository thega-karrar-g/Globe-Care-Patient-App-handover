import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/shared/different_dialogs.dart';
import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../qr_scanner/qr_scanner_logic.dart';
import '../appointment_base_controllers/booking_base_controller.dart';

class BookInvoiceLogic extends BaseController {
  bool booked = false,agreeTermsConditions=false;

  int index = 0;

  // double vat = 0;
  double  discount=0.0;
  int  discountId=0;

  var isIos = Platform.isIOS;
  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  TextEditingController qrCtrl = TextEditingController();

  changePaymentType(int i) {
    index = i;

    if (i == 0) {
      BookingConstants.paymentType = AppStrings.cash.toLowerCase();
    } else {
      BookingConstants.paymentType = AppStrings.insurance.toLowerCase();
    }

    update();
  }

  void navToPayment({bool applePay = false}) {
    if (currentUser != null) {

      if(agreeTermsConditions) {
        BookingBaseController().createAppointment(applePay: applePay);
      }
      else{
        buildFailedSnackBar(msg: AppStrings.agreeRequired.tr);

      }

    } else {
      buildFailedSnackBar(msg: AppStrings.loginRequired.tr);
    }
  }

updateAgreeTermsConditions(bool value){

    agreeTermsConditions=value;
update();
}

  checkCoupon()async{

    if(QrScannerLogic.qrCtrl.text.isNotEmpty){


      print(QrScannerLogic.qrCtrl.text);

      // print(BookingConstants.discountCategory);
DifferentDialog.showProgressDialog();
      var data={'code':QrScannerLogic.qrCtrl.text,'type':BookingConstants.discountCategory};
      var result= await _appointmentRepository.checkDiscount(data);
      Get.back();

      if(result['success']==1){

        if(result['data']['percent'] !=null){

         BookingConstants.percentDiscount=result['data']['percent'];
         BookingConstants.discountId=result['data']['id'];
        }


      }
      else{
        BookingConstants.percentDiscount=0;
        BookingConstants.discountId=0;
        buildFailedSnackBar(msg: AppStrings.couponInvalidOrExpiredMsg.tr);
      }
update();
print(result);

print(BookingConstants.percentDiscount);

    }
    else{

      buildFailedSnackBar(msg: AppStrings.couponEmptyCodeMsg.tr);


    }




  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    print("****************  from init book invoice type: ${BookingConstants.appointmentType}");
    BookingConstants. vat = 0;

    QrScannerLogic.qrCtrl.clear();
    BookingConstants.percentDiscount = 0;
    BookingConstants.discountId = 0;
    BookingConstants.price = 0;
    BookingConstants.price =
        double.parse(BookingConstants.service.price) * BookingConstants.service.quantity;
    if (BookingConstants.service2.id != 0) {
      BookingConstants.price += double.parse(BookingConstants.service2.price) *
          BookingConstants.service2.quantity;
    }
    if (BookingConstants.service3.id != 0) {
      BookingConstants.price += double.parse(BookingConstants.service3.price) *
          BookingConstants.service3.quantity;
    }

   // logger.i('********************************  price ${BookingVars.price}');



  }
}
