import 'package:get/get.dart';
import 'package:globcare/app/modules/appointment_requests_module/caregiver_contract_questionnaire/caregiver_contract_questionnaire_view.dart';
import 'package:globcare/app/modules/booking_home_modules/nurse_services/nurse_services_logic.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/eunums/enums.dart';
import '../../../data/repositories/appointment_repository.dart';
import '../../../routes/app_route_names.dart';
import '../../../data/api/api_keys.dart';
import '../../../data/api/app_urls.dart';
import '../../my_profile_module/requested_payment/requested_payment_logic.dart';
import '../instant_consultation_module/instant_consultation_states/instant_consultation_states_logic.dart';
import '../patient_data/patient_data_logic.dart';

class ReceiptPaymentLogic extends BaseController {
  late final String transId,amount, responseCode, appointmentId;
  late final String result;
  // final String amount = '';

  bool isSleepRequest=false;
  bool isCaregiverContractRequest=false;

  final String cardToken = '';
   String cardBrand = '';
  final String maskedPan = '';
  String failRoute = AppRouteNames.invoicePage;

  final AppointmentRepository _appointmentRepository = AppointmentRepository();

  bool  isSleepOrCaregiver=[ChooseDateType.sleepMedicine,ChooseDateType.caregiver].contains(PatientDataLogic.chooseDateType);
  String successMsg=AppStrings.paymentSuccess.tr;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();



    if(isSleepOrCaregiver){
      successMsg +=' ${AppStrings.willContactASAP.tr}';

    }

    appointmentId = Get.arguments['orderId'];
    responseCode = Get.arguments['respCode'];
    transId = Get.arguments['transId'];
    amount = Get.arguments['amount'];
    cardBrand = Get.arguments['cardBrand'];
    failRoute = Get.arguments['failRoute'] ?? AppRouteNames.invoicePage;

    payment();
    _visibleTokenDetails();
  }

  payment() async {
    var data = {
      ApiKeys.appointmentType:
          BookingConstants.paymentAppointmentType.name,
      BookingConstants.paymentFromInstantCons
          ? ApiKeys.consultationId
          : ApiKeys.appointmentId: appointmentId,
      ApiKeys.paymentReference: transId,

      'consultancy_price': amount,
      'deduction_amount':amount,
      'payment_method_name':cardBrand,



    };

    bool isNurseServicesLogicRegistered=Get.isRegistered<NurseServicesLogic>();
    if(isNurseServicesLogicRegistered&&  Get.find<NurseServicesLogic>().homeService.code=='SM'){
      data[ApiKeys.appointmentType]='sleep';
      isSleepRequest=true;
    }

    if( isNurseServicesLogicRegistered && Get.find<NurseServicesLogic>().homeService.code=='Car'){
      data[ApiKeys.appointmentType]='caregiver';
      isCaregiverContractRequest=true;

    }

    if (responseCode != '000') {
      data = {



        ApiKeys.appointmentType: BookingConstants.paymentAppointmentType.toString().split('.')[1],



        ApiKeys.appointmentId: appointmentId,
        ApiKeys.paymentReference: '0',
        'consultancy_price': '0',

        'deduction_amount':'0'

      };

      if( isNurseServicesLogicRegistered && Get.find<NurseServicesLogic>().homeService.code=='SM'){
        data[ApiKeys.appointmentType]='sleep';
      }

      if( isNurseServicesLogicRegistered && Get.find<NurseServicesLogic>().homeService.code=='Car'){
        data[ApiKeys.appointmentType]='caregiver';
      }

    }
    setBusy(true);

    //  DifferentDialog.showProgressDialog();
     logger.i('setPayment\n $data');

    if (failRoute == AppRouteNames.requestedPaymentDetails) {
      var paymentReference = responseCode == '000' ? transId : '';

      RequestedPaymentLogic().setRequestedPaymentStatus(paymentReference: paymentReference,brandName: cardBrand,price: amount);
    } else {

     logger.i("start setPaymentStatus  data \n $data");

     var rss=  await _appointmentRepository.setPaymentStatus(data,
          url: BookingConstants.paymentFromInstantCons
              ? AppUrls.setPaymentStatusInstantCons
              : AppUrls.setPaymentStatus);

    logger.i('setPayment  result: \n ${rss}');

if(rss[ApiKeys.responseSuccess]==1&&responseCode=='000'){


  // buildSuccessSnackBar(msg: AppStrings.paymentSuccess.tr);

  Future.delayed(Duration(seconds: 2),(){



    if (BookingConstants.paymentFromInstantCons) {
      if (responseCode == '000') {
        InstantConsultationStatesLogic.instantConsultationStatus =
            InstantConsultationStatus.startMeeting;
     Get.find<InstantConsultationStatesLogic>().update();

      }

      Get.offAllNamed(AppRouteNames.homeTabs);


      Get.toNamed(AppRouteNames.instantConsultation,);

      Future.delayed(Duration(milliseconds: 3),(){


      });


    }

    else{


      if( isNurseServicesLogicRegistered && Get.find<NurseServicesLogic>().homeService.code=='SM'){

        Get.offAllNamed(AppRouteNames.homeTabs);
        Get.toNamed(AppRouteNames.sleepQuestionnaire,arguments: appointmentId);

      }

   else   if( isNurseServicesLogicRegistered && Get.find<NurseServicesLogic>().homeService.code=='Car'){

        Get.offAllNamed(AppRouteNames.homeTabs);

        Get.toNamed(CaregiverContractQuestionnairePage.routeName,arguments: appointmentId);

      }

   else {
        Get.offAllNamed(AppRouteNames.homeTabs);
      }

      //Get.offNamedUntil(AppRouteNames.homeTabs,(route) => Get.currentRoute ==AppRouteNames.homeTabs,);
    }

  });

}


    }



    setBusy(false);
    // Get.back();
  }

  bool visibilityToken = false;

  void _visibleTokenDetails() {
    var tok = cardToken;
    if (tok == "" || tok == "null") {
      visibilityToken = false;
    } else {
      print('Token else$tok');
      visibilityToken = true;
    }

    update();
  }
}
