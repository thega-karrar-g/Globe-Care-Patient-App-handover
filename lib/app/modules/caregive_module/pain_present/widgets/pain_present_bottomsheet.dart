import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../global_widgets/shared/bottom_sheet_line.dart';
import '../../../../global_widgets/shared/dropdown_item.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../pain_present_logic.dart';

class PainPresentBottomSheet extends StatelessWidget {
  const PainPresentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
height: Get.height*.7,
      child: GetBuilder<PainPresentLogic>(builder: (logic) {
        return SingleChildScrollView(
          child: Column(children: [


Row(children: [
Expanded(child:   Ui.titleGreenUnderLine('Pain Present',fontSize: 18),
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


            Ui.titlePrimary('Score',topPadding: 5),

            DropDownItem(controller: logic.scoreCtrl, list: logic
                .scoresList, hint: AppStrings.selectScore,id: logic.scoreValue,onSelect: (item){
              logic.scoreValue=item.name.toString();
            }),





            Ui.titlePrimary('Scale Used',topPadding: 5),

            DropDownItem(controller: logic.scaleCtrl, list: logic
                .scaleList, hint: AppStrings.selectScale,id: logic.scaleValue,onSelect: (item){
              logic.scaleValue=item.name.toString();
            }),



             Container(
               decoration: BoxDecoration(
                   color: AppColors.primaryColorOpacity,
                   borderRadius: BorderRadius.circular(10)
               ),
               child: Row(
                 children: [
                   BottomSheetLine(title: 'Comment',length: 5000, controller: logic.commentCtrl,isMultLine: true,unit: '',),
                                  ],
               ),
             ),
            UiHelper.verticalSpaceMedium,



            Row(
              children: [

                Expanded(child:   Ui.primaryButton(title: 'Reset',color: AppColors.primaryColorGreen,fontSize: 15,onTab: (){

logic.resetTextCtrls();

                }),),

                UiHelper.horizontalSpaceMedium,

                Expanded(child:   Ui.primaryButton(title: 'Save',fontSize: 15,onTab: (){
                // print(logic.scoreCtrl.text.length);
                  logic.addPainPresent();
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
