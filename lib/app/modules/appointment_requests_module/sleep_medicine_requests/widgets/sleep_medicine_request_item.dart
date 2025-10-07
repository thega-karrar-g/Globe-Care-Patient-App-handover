import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/assets_helper/app_images.dart';
import 'package:globcare/app/core/language_and_localization/app_strings.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';
import 'package:globcare/app/utils/string_reverse.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../data/models/sleep_medicine_model.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../routes/app_route_names.dart';
import '../sleep_medicine_requests_controller.dart';

class SleepMedicineRequestItem extends StatelessWidget {
  const SleepMedicineRequestItem({Key? key,required this.sleepMedicineModel}) : super(key: key);

  final SleepMedicineModel sleepMedicineModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 2.w,vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColorOpacity,

        borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1,
                blurRadius: 1,
                color: AppColors.primaryColor.withOpacity(.08)
            )
          ]


      ),

      child: Column(children: [

        Row(children: [
          Text("# ${sleepMedicineModel.name}",style: AppStyles.primaryStyle(bold: true),),
        ],),
        UiHelper.verticalSpaceSmall,
        Row(children: [
          Image.asset(AppImages.iconSleep,width: 30.w,height: 30.h,),
          UiHelper.horizontalSpaceSmall,
          Text(" ${sleepMedicineModel.service.name}",style: AppStyles.primaryStyle(bold: true,fontSize: 12),),
        ],),
        UiHelper.verticalSpaceSmall,

        Row(children: [
          Image.asset(AppImages.progress,width: 30.w,height: 30.h,),
          UiHelper.horizontalSpaceSmall,
          Text(getStatusName(),style: AppStyles.primaryStyle(fontSize: 12),),
        ],),


        UiHelper.verticalSpaceMedium,

        if(['paid','evaluation'].contains(sleepMedicineModel.state) )
        Row(children: [

          if(sleepMedicineModel.state =="evaluation")

            Expanded(child: Ui.primaryButton(title: AppStrings.joinMeeting,paddingH: 10,paddingV: 10,fontSize: 12,marginV: 0,onTab: (){


            Get.find<SleepMedicineRequestsController>().startMeeting(sleepMedicineModel);


          })),
          UiHelper.horizontalSpaceSmall,
          Expanded(child: Ui.primaryButton(title: AppStrings.fillQuestioner,paddingH: 10,paddingV: 10,fontSize: 12,marginV: 0,onTab: (){

            Get.toNamed(AppRouteNames.sleepQuestionnaire,arguments: sleepMedicineModel.id);

          })),

        ],),



      ],),

    );
  }


 String getStatusName(){


    switch(sleepMedicineModel.state){

      case 'unpaid': {  return AppStrings.unpaid.tr; }
      case 'paid': {  return AppStrings.paid.tr; }
      case 'evaluation': {  return AppStrings.evaluation.tr; }
      case 'scheduling': {  return AppStrings.scheduling.tr; }
      case 'cancel': {  return AppStrings.canceled.tr; }
      case 'create_appointment': {  return AppStrings.appointmentCreated.tr; }

      default :{ return ''; }




    }



  }
}
