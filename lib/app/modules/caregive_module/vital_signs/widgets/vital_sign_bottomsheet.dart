import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/bottom_sheet_line.dart';
import '../../../../global_widgets/shared/dropdown_item.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../vital_signs_logic.dart';


class VitalSignBottomSheet extends StatelessWidget {
  const VitalSignBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
height: Get.height*.75,
      child: GetBuilder<VitalSignsLogic>(builder: (logic) {
        return SingleChildScrollView(
          child: Column(children: [


Row(children: [
Expanded(child:   Ui.titleGreenUnderLine('Vital Sings',fontSize: 18),
),
  GestureDetector(onTap: (){
    Get.back();
  },

    child: Column(
      children: [
        Icon(Icons.close,color: AppColors.primaryColor,size: 30.h,),
        UiHelper.verticalSpaceMedium,
      ],
    ),
  )




],),
             Container(
               decoration: BoxDecoration(
                   color: AppColors.primaryColorOpacity,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: Row(
                 children: [
                 //  BottomSheetLine(title: 'Weight', controller: logic.weightCtrl,unit: 'kg',isInt: true,),
                   BottomSheetLine(title: 'Heart Rate', controller: logic.heartRateCtrl,isDecimal: true,),


                   BottomSheetLine(title: 'O₂ Saturation', controller: logic.oxygenSaturationCtrl,unit: '%',isInt: true,),
                 ],
               ),
             ),


            Ui.titlePrimary('O₂ Saturation Status : ',topPadding: 5,),

            DropDownItem(controller: logic.oxygenSaturationStateCtrl, list: logic
                .stateList, hint: AppStrings.selectStatus,id: logic.stateValue,onSelect: (item){
              logic.stateValue=item.name.toString();
            }),


            UiHelper.verticalSpaceMedium,

            Container(
               decoration: BoxDecoration(
                   color: AppColors.primaryColorOpacity,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: Row(
                 children: [
                   BottomSheetLine(title: 'Blood Pressure',unit: '', controller: logic.bloodPressureDCtrl,length: 3,hasSlash: true,isInt: true,),
                   Text('/',style: AppStyles.primaryStyle(color: AppColors.primaryColorGreen,fontSize: 30,height: 2),),
                   BottomSheetLine(title: '',unit: '', controller: logic.bloodPressureSCtrl,length: 3,hasSlash: true,isInt: true,),

                   Text('mmHg',style: AppStyles.primaryStyle(color: AppColors.primaryColorGreen,height: 3),),

                   UiHelper.horizontalSpaceMassive,
                   UiHelper.horizontalSpaceMedium,
                   UiHelper.horizontalSpaceMassive,

                 ],
               ),
             ),
             UiHelper.verticalSpaceMedium,
             Container(
               decoration: BoxDecoration(
                   color: AppColors.primaryColorOpacity,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: Row(
                 children: [
                   BottomSheetLine(title: 'Respiration',controller: logic.respirationCtrl,flex: 3,isInt: true,),

                   BottomSheetLine(title: 'Temperature', unit: '°C',controller: logic.temperatureCtrl,flex: 2,length: 4,isDecimal: true,),
                   BottomSheetLine(title: 'Blood Sugar', controller: logic.bloodSugarCtrl,unit: 'mg/dl',flex: 3,isInt: true,),
                 ],
               ),
             ),


            Row(
              children: [

                Expanded(child:   Ui.primaryButton(title: 'Reset',color: AppColors.primaryColorGreen,fontSize: 15,onTab: (){

logic.resetVitalSign();
                }),),

                UiHelper.horizontalSpaceMedium,

                Expanded(child:   Ui.primaryButton(title: 'Save',fontSize: 15,onTab: (){

                  logic.addVital();
                 // Get.back();
                }),),

              ],
            )
          ],),
        );
      }),


    );
  }
}
