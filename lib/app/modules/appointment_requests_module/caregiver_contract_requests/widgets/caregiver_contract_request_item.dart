import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/shared/different_dialogs.dart';
import 'package:intl/intl.dart';


import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/caregiver_contract_model.dart';
import '../../../../data/models/sleep_medicine_model.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../global_widgets/ui.dart';
import '../../../../routes/app_route_names.dart';
import '../../caregiver_contract_questionnaire/caregiver_contract_questionnaire_view.dart';
import '../caregiver_contract_requests_controller.dart';

class CaregiverContractRequestItem extends StatelessWidget {
  const CaregiverContractRequestItem({Key? key,required this.caregiverContract}) : super(key: key);

  final CaregiverContractModel caregiverContract;
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
          Text("# ${caregiverContract.name}",style: AppStyles.primaryStyle(bold: true),),
        ],),
        UiHelper.verticalSpaceSmall,
        Row(children: [
          Image.asset(AppImages.iconCaregiver,width: 30.w,height: 30.h,),
          UiHelper.horizontalSpaceSmall,
          Text(" ${caregiverContract.service.name}",style: AppStyles.primaryStyle(bold: true,fontSize: 12),),
        ],),
        UiHelper.verticalSpaceSmall,

        Row(children: [
          Image.asset(AppImages.progress,width: 30.w,height: 30.h,),
          UiHelper.horizontalSpaceSmall,
          Text("${AppStrings.status.tr} : ${getStatusName()}",style: AppStyles.primaryStyle(fontSize: 12),),
        ],),

        if(['hold','holdreq','active','completed'].contains( caregiverContract.state) && caregiverContract.startingDate.isNotEmpty && caregiverContract.endingDate.isNotEmpty)
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              children: [
            Icon(FontAwesomeIcons.calendarDays),
            UiHelper.horizontalSpaceSmall,
            Text(" ${ AppStrings.from.tr + ( caregiverContract.startingDate)  }  ${ AppStrings.to.tr.capitalizeFirst! + ( caregiverContract.endingDate)}",style: AppStyles.primaryStyle(fontSize: 12),),
                    ],
            ),
          ),


        UiHelper.verticalSpaceMedium,

        if(['paid','evaluation'].contains(caregiverContract.state) )
        Row(children: [

          if(caregiverContract.state =="evaluation")

            Expanded(child: Ui.primaryButton(title: AppStrings.joinMeeting,paddingH: 10,paddingV: 10,fontSize: 12,marginV: 0,onTab: (){


            Get.find<CaregiverContractRequestsController>().startMeeting(caregiverContract);


          })),
          UiHelper.horizontalSpaceSmall,
          Expanded(child: Ui.primaryButton(title: AppStrings.fillQuestioner,paddingH: 10,paddingV: 10,fontSize: 12,marginV: 0,onTab: (){

            Get.toNamed(CaregiverContractQuestionnairePage.routeName,arguments: caregiverContract.id);

          })),

        ],),

        // if( caregiverContract.state !='unpaid')

        Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.h),
          child: Row(children: [

            Expanded(child: Ui.primaryButton(title: AppStrings.agreedPolicies,paddingH: 5,paddingV: 10,color: AppColors.primaryColorGreen,marginV: 0,fontSize: 12,onTab: (){

             // Get.toNamed(AppRouteNames.termsOfService);

              DifferentDialog.showCaregiverContractDialog();

            })),

            if(caregiverContract.pdfLink.isNotEmpty)
            UiHelper.horizontalSpaceMedium,
            if(caregiverContract.pdfLink.isNotEmpty)
            Expanded(child: Ui.primaryButton(title: AppStrings.contract,iconSize: 20,paddingH: 0,paddingV: 10,color: AppColors.primaryColorGreen,icon: Icons.picture_as_pdf,marginV: 0,fontSize: 12,onTab: (){


              Get.find<CaregiverContractRequestsController>().onTabFileContract(caregiverContract);


            })),



          ],),
        ),

        if(   caregiverContract.state =='active' )

        Padding(
          padding:  EdgeInsets.symmetric(vertical: 10.h),
          child: Row(children: [

            Expanded(child: Ui.primaryButton(title: AppStrings.holdRequest,paddingH: 10,paddingV: 10,color: AppColors.primaryColor,marginV: 0,fontSize: 12,onTab: (){



              DifferentDialog.showSureDialog(
                  actionTitle: AppStrings.holdRequest,
                  onSure: (){
                    Get.find<CaregiverContractRequestsController>().updateCaregiverContract(caregiverContract.id, "holdreq");

                  });



            })),

            UiHelper.horizontalSpaceMedium,

            Expanded(child: Ui.primaryButton(title: AppStrings.terminationRequest,paddingH: 10,paddingV: 10,color: AppColors.red,marginV: 0,fontSize: 12,onTab: (){


              DifferentDialog.showSureDialog(
                  actionTitle: AppStrings.terminationRequest,
                  onSure: (){
                Get.find<CaregiverContractRequestsController>().updateCaregiverContract(caregiverContract.id, "terminationreq");

              });


            //  Get.toNamed(AppRouteNames.termsOfService);

            })),

          ],),
        ),





      ],),

    );
  }


  String getStatusName(){


    switch(caregiverContract.state){

      case 'unpaid': {  return AppStrings.unpaid.tr; }
      case 'paid': {  return AppStrings.paid.tr; }
      case 'evaluation': {  return AppStrings.evaluation.tr; }
      case 'renew': {  return AppStrings.renewContract.tr; }
      case 'cancel': {  return AppStrings.canceledContract.tr; }
      case 'active': {  return AppStrings.contractActive.tr; }
      case 'assign_caregiver': {  return AppStrings.assignCaregiver.tr; }
      case 'holdreq': {  return AppStrings.holdRequest.tr; }
      case 'hold': {  return AppStrings.holdContract.tr; }
      case 'terminationreq': {  return AppStrings.terminationRequest.tr; }
      case 'terminated': {  return AppStrings.contractTerminated.tr; }
      case 'completed': {  return AppStrings.completedContract.tr; }

      default :{ return ''; }




    }



  }

}
