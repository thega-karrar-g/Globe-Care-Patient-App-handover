import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';
import 'package:globcare/app/modules/booking_home_modules/patient_data/patient_data_logic.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../global_widgets/ui.dart';

class SelectNationality extends StatelessWidget {
  const SelectNationality({Key? key,required this.logic}) : super(key: key);

  final PatientDataLogic logic;

  @override
  Widget build(BuildContext context) {
    return Column(children: [

        Row(
          children: [
            Ui.titleGreenUnderLine(
                AppStrings.selectNationality.tr,
                bottomPadding: 8),
          ],
        ),

      UiHelper.verticalSpaceMedium,


      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children:logic.nationalityList.map((e) => GestureDetector(

            onTap: (){


              logic.updateNationality(e);
            },
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
              margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: logic.requiredNationality==e? AppColors.primaryColor:AppColors.white,
                border: Border.all(color: AppColors.primaryColor)




              ),

              child: Text(e,style: AppStyles.primaryStyle(bold: logic.requiredNationality==e,fontSize: 15,color: logic.requiredNationality==e? AppColors.white:AppColors.primaryColor,),),

            ))).toList()),
      ),




    ],);
  }
}
