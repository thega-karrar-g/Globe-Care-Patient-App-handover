import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/language_and_localization/app_strings.dart';
import 'package:globcare/app/global_widgets/form_widgets/radio_form_builder.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../global_widgets/form_widgets/input_text_field_widget.dart';
import '../../../../global_widgets/ui.dart';
import '../sleep_questionnaire_logic.dart';

class QuestionnaireForm extends StatelessWidget {
   QuestionnaireForm({Key? key}) : super(key: key);
final controller=Get.find<SleepQuestionnaireLogic>();
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children:  [


        Row(
          children: [
            Expanded(child: InputTextFieldWidget(keyName: "weight",isRequired: true,isNumeric: true,

              labelText: AppStrings.weightKg.tr.capitalize!,
              hintText: AppStrings.weightKg.tr,
              fillColor: AppColors.white,
              inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.h),



                  borderSide: const BorderSide(color: AppColors.primaryColor)
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly,

              ],

            )),
            UiHelper.horizontalSpaceMedium,
            Expanded(child: InputTextFieldWidget(keyName: "height",isRequired: true,isNumeric: true,
              labelText: AppStrings.height.tr.capitalize!,

              hintText: AppStrings.height.tr,
              fillColor: AppColors.white,

              inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.h),



                  borderSide: const BorderSide(color: AppColors.primaryColor)
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
                FilteringTextInputFormatter.digitsOnly,


              ],
            )),
          ],
        ),


        UiHelper.verticalSpaceMedium,

        RadioFormBuilder(formKey: "question1",title: AppStrings.sleepQuestionnaireQ1.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),



        RadioFormBuilder(formKey: "question2",title: AppStrings.sleepQuestionnaireQ2.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),

        RadioFormBuilder(formKey: "question3",title: AppStrings.sleepQuestionnaireQ3.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),



        RadioFormBuilder(formKey: "question4",title: AppStrings.sleepQuestionnaireQ4.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),


        RadioFormBuilder(formKey: "question5",title: AppStrings.sleepQuestionnaireQ5.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),



        RadioFormBuilder(formKey: "question6",title: AppStrings.sleepQuestionnaireQ6.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),


        UiHelper.verticalSpaceLarge,

        Ui.primaryButton(
            title: AppStrings.send,
            marginV: 20,
            onTab: () {
              controller.send();
            })


      ],),
    );
  }
}
