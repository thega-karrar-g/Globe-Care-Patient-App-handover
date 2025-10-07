import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/language_and_localization/app_strings.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:globcare/app/global_widgets/form_widgets/radio_form_builder.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../global_widgets/form_widgets/input_text_field_widget.dart';
import '../../../../global_widgets/ui.dart';
import '../caregiver_contract_questionnaire_logic.dart';

class QuestionnaireForm extends StatelessWidget {
   QuestionnaireForm({Key? key}) : super(key: key);
final controller=Get.find<CaregiverContractQuestionnaireLogic>();
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children:  [




        UiHelper.verticalSpaceMedium,

        RadioFormBuilder(formKey: "question1",title: AppStrings.caregiverQuestionnaireQ1.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),



        RadioFormBuilder(formKey: "question2",title: AppStrings.caregiverQuestionnaireQ2.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          if(value=="yes"){
            controller.isSpecify=true;
          }
          else{
            controller.isSpecify=false;
          }
          controller.update();
        },).paddingSymmetric(vertical: 16.h),

if(controller.isSpecify)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.specify.tr,style: AppStyles.primaryStyle(),),
              InputTextFieldWidget(keyName: "question2_text",isRequired: true,
                labelText: AppStrings.specify.tr.capitalize!,

                // hintText: AppStrings.specify.tr,
                fillColor: AppColors.white,

                inputBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.h),



                    borderSide: const BorderSide(color: AppColors.primaryColor)
                ),
              ).paddingSymmetric(vertical: 10.h),
            ],
          ),




        DottedLine(dashColor: AppColors.primaryColor,),

        RadioFormBuilder(formKey: "question3",title: AppStrings.caregiverQuestionnaireQ3.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),



        RadioFormBuilder(formKey: "question4",title: AppStrings.caregiverQuestionnaireQ4.tr,values: controller.seatValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),


        RadioFormBuilder(formKey: "question5",title: AppStrings.caregiverQuestionnaireQ5.tr,values: controller.foodValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),



        RadioFormBuilder(formKey: "question6",title: AppStrings.caregiverQuestionnaireQ6.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),

        RadioFormBuilder(formKey: "question7",title: AppStrings.caregiverQuestionnaireQ7.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),

        RadioFormBuilder(formKey: "question8",title: AppStrings.caregiverQuestionnaireQ8.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),

        RadioFormBuilder(formKey: "question9",title: AppStrings.caregiverQuestionnaireQ9.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),
        DottedLine(dashColor: AppColors.primaryColor,),

        RadioFormBuilder(formKey: "question10",title: AppStrings.caregiverQuestionnaireQ10.tr,values: controller.yesNoFormValues,isRequired: true,onChange: (value){

          controller.update();
        },).paddingSymmetric(vertical: 16.h),

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
