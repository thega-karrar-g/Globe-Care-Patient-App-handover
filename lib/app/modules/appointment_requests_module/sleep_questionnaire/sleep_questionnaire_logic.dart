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

class SleepQuestionnaireLogic extends BaseController {
  // final AppointmentApi _appointmentApi = AppointmentApi();
  final AppointmentRequestsRepository appointmentRequestsRepository=AppointmentRequestsRepository();
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final yesNoFormValues={"yes":"Yes","no":"No"};

  dynamic questionnaireId=Get.arguments;
  List<Questionnaire> questions = [
    Questionnaire(id: 1, question: 'Do you snore?', questionAr: 'هل تشخّر؟'),
    Questionnaire(
        id: 2,
        question:
            "Do you wake up feeling lite he/she hasn't slept, and feeling fatigued during the day? ",
        questionAr:
            'هل تستيقظ من النوم ولديك شعور بأنك لم تنام وتشعر بالتعب أثناء النهار؟'),
    Questionnaire(
        id: 3,
        question:
            'Have you been told that you stop breathing at night? Do you gasp for air or choke while sleeping?',
        questionAr:
            'هل قيل لك أن تنفسك يتوقف أثناء الليل وتشعر بصعوبة في التنفس أو الاختناق أثناء النوم؟'),
    Questionnaire(
        id: 4,
        question:
            'Do you have high blood pressure or on medication to control high blood pressure?',
        questionAr:
            'هل ضفط الدم لديك مرتفع؟ أو تستخدم أدوية للتحكم بارتفاع الضغط؟'),
    Questionnaire(id: 5, question: 'Are you male?', questionAr: 'هل أنت ذكر؟'),
    Questionnaire(
        id: 6,
        question: 'Are you 50 years old or older?',
        questionAr: 'هل عمرك 50 أو أكثر؟'),
  ];

  Questionnaire nationality = Questionnaire(
      answer: true,
      questionAr: 'الجنسية: سعودي',
      question: AppStrings.saudiNationality);

  updateNationality() {
    // nationality.answer=! nationality.answer;
    update();
  }

  updateQuestion(Questionnaire q) {
    q.answer = !q.answer!;
    update();
  }

  final neckKey = 'neck_circ';
  final heightKey = 'height';
  final weightKey = 'weight';

  late FormGroup form;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    form = FormGroup({
      weightKey: FormControl<String>(validators: [Validators.required]),
      heightKey: FormControl<String>(validators: [Validators.required]),
    });
  }

  void send() async {
    Map<String, dynamic> data = {};
// print("********************");
    if (formKey.currentState!.validate() ) {
      formKey.currentState?.save();

      var value=formKey.currentState!.value;


      var h = double.parse(value["height"].toString());
      var w = double.parse(value["weight"].toString());
print(w);
print(h);
      if (w > 300 || w == 0) {
        print("***************  w");
        buildFailedSnackBar(msg: AppStrings.weightKgMsg.tr);
      } else if (h > 250 || h == 0) {
        print("****************");
        buildFailedSnackBar(msg: AppStrings.heightMsg.tr);
      } else {


          // print("valid *****************");

          data.addAll(value);
          data.addAll({
            ApiKeys.id:questionnaireId.toString(),});

          print(data);
          if (!noInternetConnection()) {
            DifferentDialog.showProgressDialog();


              try {
                var response=  await    appointmentRequestsRepository.requestSleepMedicine(data);

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
        }

    } else {
      buildFailedSnackBar(msg: AppStrings.fillHWFields.tr);
    }
  }
}
