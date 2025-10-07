import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/refund_request_model.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class RefundRequestItem extends StatelessWidget {
  const RefundRequestItem({Key? key,required this.refundRequestModel}) : super(key: key);
 final RefundRequestModel refundRequestModel;
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
          Text("# ${refundRequestModel.name}",style: AppStyles.primaryStyle(bold: true),),
        ],),
        UiHelper.verticalSpaceSmall,



        Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.h),
          child: Row(children: [
            Image.asset(AppImages.apptType,width: 30.w,height: 30.h,),
            UiHelper.horizontalSpaceSmall,
            Text(getTypeName(),style: AppStyles.primaryStyle(fontSize: 12),),
          ],),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.h),
          child: Row(children: [
            Image.asset(AppImages.appointmentIcon,width: 30.w,height: 30.h,),
            UiHelper.horizontalSpaceSmall,
            Text(refundRequestModel.appointment.name,style: AppStyles.primaryStyle(fontSize: 12),),
          ],),
        ),

        UiHelper.verticalSpaceSmall,


        Row(children: [
          Image.asset(AppImages.progress,width: 30.w,height: 30.h,),
          UiHelper.horizontalSpaceSmall,
          Text(getStatusName(),style: AppStyles.primaryStyle(fontSize: 12),),
        ],),


        // UiHelper.verticalSpaceMedium,
        UiHelper.verticalSpaceSmall,
        if(refundRequestModel.reason.trim().isNotEmpty)

          Padding(
            padding:  EdgeInsets.symmetric(vertical: 8.h),
            child: Row(children: [
              Image.asset(AppImages.reason,width: 30.w,height: 30.h,),

              UiHelper.horizontalSpaceSmall,
              Text(" ${refundRequestModel.reason}",style: AppStyles.primaryStyle(bold: true,fontSize: 12),),
            ],),
          ),


      ],),

    );
  }

  String getTypeName(){


    switch(refundRequestModel.type){

      case 'hhc_appointment': {  return AppStrings.hhcAppointments.tr; }
      case 'tele_appointment': {  return AppStrings.telemedicineAppointments.tr; }
      case 'hvd_appointment': {  return AppStrings.homeVisitAppointments.tr; }
      case 'phy_appointment': {  return AppStrings.physiotherapistAppointments.tr; }
      case 'instant': {  return AppStrings.instantConsultation.tr; }
      case 'caregiver': {  return AppStrings.caregiverContractsRequests.tr; }
      case 'package': {  return AppStrings.package.tr; }
      case 'multipackage': {  return AppStrings.package.tr; }

      default :{ return AppStrings.other.tr; }




    }



  }
  String getStatusName(){


    switch(refundRequestModel.state){

      case 'received': {  return AppStrings.received.tr; }
      case 'operation_manager': {  return AppStrings.underReview.tr; }
      case 'Reject': {  return AppStrings.refundRejected.tr; }
      case 'Processed': {  return AppStrings.refundAccepted.tr; }
      case 'cancel': {  return AppStrings.refundCanceled.tr; }
      case 'Refund': {  return AppStrings.refunded.tr; }

      default :{ return ''; }




    }



  }

}
