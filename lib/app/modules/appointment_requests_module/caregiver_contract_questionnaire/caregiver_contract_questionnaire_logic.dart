import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../data/api/appointment_api.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/models/questionnaire.dart';
import '../../../data/repositories/appointment_requests_repository.dart';
import '../../../global_widgets/shared/different_dialogs.dart';
import '../../../data/api/api_keys.dart';

class CaregiverContractQuestionnaireLogic extends BaseController {
  // final AppointmentApi _appointmentApi = AppointmentApi();
  final AppointmentRequestsRepository appointmentRequestsRepository=AppointmentRequestsRepository();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final yesNoFormValues={"yes":"Yes","no":"No"};
  final seatValues={"move":AppStrings.move,"seated":AppStrings.seated};
  final foodValues={"eat_food":AppStrings.eatFood,"feeding_tube":AppStrings.feedingTube};

  dynamic questionnaireId=Get.arguments;


  bool isSpecify=false;


  final neckKey = 'neck_circ';
  final heightKey = 'height';
  final weightKey = 'weight';

  late FormGroup form;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  void send() async {
    Map<String, dynamic> data = {};
// print("********************");
    if (formKey.currentState!.validate() ) {
      formKey.currentState?.save();

      var value=formKey.currentState!.value;




          // print("valid *****************");

          data.addAll(value);
          data.addAll({
            ApiKeys.id:questionnaireId.toString(),});

          print(data);
          if (!noInternetConnection()) {
            DifferentDialog.showProgressDialog();


              try {
                var response=  await    appointmentRequestsRepository.requestCaregiverContract(data);

                print(response);
                // var response = value!.data;

                Get.back();
                if (response['success'] == 1) {
                  //    buildSuccessSnackBar(msg: response['data']['message']);
                  print(response['data']['message']);

                  //   await DifferentDialog.hideProgressDialog();
                  DifferentDialog.showRequestServiceSuccessDialog(
                      msg: AppStrings.sleepMedOkMsg);

                  // Get.toNamed(AppRouteNames.successRegister);

                } else {
                  buildFailedSnackBar(msg: AppStrings.errorMsg.tr);
                }
              } catch (_) {}

          } else {
            buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
          }


    } else {
      buildFailedSnackBar(msg: AppStrings.fillHWFields.tr);
    }
  }



}
