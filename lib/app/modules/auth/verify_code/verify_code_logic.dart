import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_mask/string_mask.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api/api.dart';
import '../../../data/api/auth_api.dart';
import '../../../data/api/sms_api.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/models/user_model.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../routes/app_route_names.dart';
import '../../../data/api/api_keys.dart';
import '../../appointment/appointment_types_logic.dart';
import '../../booking_home_modules/instant_consultation_module/instant_consultation_home/instant_consultation_home_logic.dart';
import '../../booking_home_modules/instant_consultation_module/instant_consultation_home/instant_consultation_home_view.dart';
import '../../booking_home_modules/patient_data/patient_data_logic.dart';
import '../../select_patient/select_patient_logic.dart';
import '../auth_controller.dart';

class VerifyCodeLogic extends BaseController {
  var formatter = StringMask(
    '+ (000) 0  0000  0000',
  );
  TextEditingController textEditingController = TextEditingController();
  final AuthApi _authApi = AuthApi();
  final AuthController _authController = AuthController();
  DateTime alert = DateTime.now().add(Duration(seconds: 10));

  final SMSApi _smsApi = SMSApi();

  String phoneNum = '966597217452', code = '';

//966597217452

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    if (Get.arguments is AppUser) {
      user = Get.arguments;
      phoneNum = user!.phone;
    } else {
      data = Get.arguments;
      phoneNum = '966${data[ApiKeys.formMobile]}';
    }

    sendCode();
  }

  Map<String, dynamic> data = {};
  AppUser? user;

  sendCode() async {
    code = generateCode();


    // debugPrint("****************************  code $code");

    Map<String, dynamic> body = {
      ApiKeys.smsUserName: ApiKeys.smsUserNameValue,
      ApiKeys.smsNumbers: phoneNum,
      ApiKeys.smsUserSender: ApiKeys.smsUserSenderValue,
      ApiKeys.smsApiKey: ApiKeys.smsApiKeyValue,
      ApiKeys.smsMsg: "${AppStrings.passwordVerifyMsg.tr}:$code"
         };
    // logger.i('************   data $code');

  var res=  await _smsApi.sendSMS(body: body);
// logger.i(res);

    //
  }

  String generateCode() {
    Random random = Random();
    String number = '';
    for (int i = 0; i < 4; i++) {
      number = number + random.nextInt(9).toString();
    }
    return number;
  }

  verify() {
    if (code == textEditingController.text) {
      if (user != null) {

        forgetPassword();
      } else {
        data.addAll({ApiKeys.formPassword: code});
        data[ApiKeys.formMobile] = phoneNum;

        logger.i('************   data $data');
        register(data);
      }
    } else {
      buildFailedSnackBar(msg: AppStrings.verifyCodeErrorMsg.tr);
    }
  }

  void register(Map<String, dynamic> data) async {

    logger.i("fromRegisterFunc");
    if (!noInternetConnection()) {
      setBusy(true);
      logger.i(data);

      DifferentDialog.showProgressDialog();

      _authApi.registerPatient(data).then((value) async {
        // try {

      //  logger.i(value!.body);

        Get.back();

        if(value!.statusCode==200) {
          // var result = json.decode(value.body.toString());
          var result = value.data;

          // logger.i("  ${result}");

          if (result[ApiKeys.responseSuccess] == 1) {
            // print('id:************************* ${result['data']['id']} ');
            // login2({'username':data['ssn'],'password':data['password']});
            //  buildSuccessSnackBar(msg: result['data']['message']);

            _authController.rememberBox
                .write(ApiKeys.remember.toLowerCase(), true);
            _authController.rememberBox.write(
                ApiKeys.smsUserName.toLowerCase(), data[ApiKeys.idNumberKey]);
            _authController.rememberBox.write(ApiKeys.formPassword, code);

            var userMap = result[ApiKeys.responseData];

            AppUser user = AppUser.fromMap(userMap);
            // user.token = Api.token;
            user.userType = '1';

            authService.saveUserInfoToHive(user);


            Get.find<AuthController>().update();



            bool isRegisteredSelectPatientLogic = Get.isRegistered<SelectPatientLogic>();

            if(isRegisteredSelectPatientLogic){

              Get.find<SelectPatientLogic>().onInit();

            }
            bool isRegisteredAppointmentTypesLogic = Get.isRegistered<AppointmentTypesLogic>();

            if(isRegisteredAppointmentTypesLogic){

              Get.find<AppointmentTypesLogic>().onInit();

            }



            if (BookingConstants.fromPatientData == true) {
              if (InstantConsultationHomeLogic.fromInstantConsultation) {
                InstantConsultationHomeLogic.fromInstantConsultation = false;

                //   Get.offNamedUntil(InstantConsultationHomePage.routeName,ModalRoute.withName(AppRouteNames.home),);

                Get.offAllNamed(AppRouteNames.homeTabs);
                Get.toNamed(
                  InstantConsultationHomePage.routeName,
                );
              }
              else {
                // Get.back(result: true);
                Get.offNamedUntil(AppRouteNames.patientData,
                  ModalRoute.withName(PatientDataLogic.previousRoute),);

                // Get.toNamed(AppRouteNames.patientData);
              }
            }

            else {
              Get.offAllNamed(AppRouteNames.homeTabs);
            }


            //   setBusy(false);

            //   await DifferentDialog.hideProgressDialog();
            //  DifferentDialog.showRegisterSuccessDialog2();

            // Get.toNamed(AppRouteNames.successRegister);

          } else {
            buildFailedSnackBar(msg: result[ApiKeys.responseMessage]);
          }

          setBusy(false);
        }
        else{
          buildFailedSnackBar(msg: AppStrings.thereIsProblem.tr);

        }

        // } catch (e) {
        //   setBusy(false);
        // }
      });
    } else {
      buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
    }
  }

  forgetPassword() async{

await _authController.resetPassword({'id':user!.id,'code':code});
    _authController.rememberBox.write(ApiKeys.remember.toLowerCase(), true);
    _authController.rememberBox
        .write(ApiKeys.smsUserName.toLowerCase(), user!.ssn);
    _authController.rememberBox.write(ApiKeys.formPassword, code);

    authService.saveUserInfoToHive(user!);

    Get.offAllNamed(AppRouteNames.homeTabs);
  }
}
