import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../global_widgets/shared/bottom_sheet_line.dart';
import '../../../../global_widgets/shared/dropdown_item.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../observation_logic.dart';


class ObservationBottomSheet extends StatelessWidget {
  const ObservationBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
height: Get.height*.6,
      child: GetBuilder<ObservationLogic>(builder: (logic) {
        return SingleChildScrollView(
          child: Column(children: [


Row(children: [
Expanded(child:   Ui.titleGreenUnderLine('Add Observation',fontSize: 18),
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

             UiHelper.verticalSpaceMedium,


            DropDownItem(title: 'Nutritional Status',controller: logic.nutritionalStatusCtrl, list: logic
                .statesList, hint: AppStrings.selectStatus,id: logic.nutritionalStatusValue,onSelect: (item){
              logic.nutritionalStatusValue=item.name.toString();
            }),

            UiHelper.verticalSpaceMedium,
            DropDownItem(title:'Sleeping Pattern' ,controller: logic.sleepingPatternCtrl, list: logic
                .statesList, hint: AppStrings.selectStatus,id: logic.sleepingPatternValue,onSelect: (item){
              logic.sleepingPatternValue=item.name.toString();
            }),




            UiHelper.verticalSpaceLarge,

             Container(
               padding: EdgeInsets.only(top: 5.h),
               decoration: BoxDecoration(
                   color: AppColors.primaryColorOpacity,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: Row(
                 children: [
                   BottomSheetLine(title: 'Progress Noted',length: 10000, controller: logic.progressNotedCtrl,isMultLine: true,unit: '',),
                                  ],
               ),
             ),
            UiHelper.verticalSpaceMedium,



            Row(
              children: [

                Expanded(child:   Ui.primaryButton(title: 'Reset',color: AppColors.primaryColorGreen,fontSize: 15,onTab: (){

logic.resetTextCtrl();

                }),),

                UiHelper.horizontalSpaceMedium,

                Expanded(child:   Ui.primaryButton(title: 'Save',fontSize: 15,onTab: (){
                  Get.back();
                }),),

              ],
            )
          ],),
        );
      }),


    );
  }
}
