import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/assets_helper/app_images.dart';
import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../global_widgets/ui.dart';
import '../../../../../core/assets_helper/app_anim.dart';
import '../instant_consultation_states_logic.dart';

class StartMeetingItem extends StatelessWidget {
  const StartMeetingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstantConsultationStatesLogic>(builder: (logic) {
      return SingleChildScrollView(
        child: DynamicColumn(
          children: [
            UiHelper.verticalSpaceMassive,
            if (logic.currentRequest != null)
              Ui.circularImg(
                url: logic.currentRequest!.doctorImgUrl,
                padding: 2,
                size: 120,
                errorImg: 'assets/images/doctor.png',
              ),
            UiHelper.verticalSpaceSmall,
            if (logic.currentRequest != null)
              Row(
                children: [
                  Expanded(
                      child: Text(
                    logic.currentRequest!.doctor,
                    textAlign: TextAlign.center,
                    style: AppStyles.primaryStyle(bold: true, fontSize: 18),
                  )),
                ],
              ),

            UiHelper.verticalSpaceSmall,
            FutureBuilder(
                initialData: PermissionStatus.denied,
                future: Permission.microphone.status,
                builder: (bc,AsyncSnapshot<PermissionStatus>snapshot){

                  if(snapshot.connectionState==ConnectionState.done) {

                    print("${snapshot.data}");

                    if(snapshot.data==PermissionStatus.granted){
                      return Container();
                    }
                    else if(snapshot.data !=PermissionStatus.granted){
                      return Row(
                        children: [
                          Expanded(
                              flex:4,
                              child: Text(AppStrings.microphonePermissionRequired.tr,style: AppStyles.primaryStyle(bold: true,color: AppColors.red,fontSize: 15,height: 1.3),)),

                          Expanded(
                            child: Ui.primaryButton(title: AppStrings.allow.tr,paddingH: 10,paddingV: 10,onTab: ()async{

                            await  Permission.microphone.request();

                            if( !(await Permission.microphone.request().isGranted)){
                              openAppSettings();}

                            }),
                          ),
                        ],
                      );

                    }
                    else {
                      return Column(
                        children: [
                          Text(AppStrings.cameraPermissionRequired.tr,style: AppStyles.primaryStyle(bold: true,color: AppColors.red,fontSize: 15,height: 1.3),),

                          Ui.primaryButton(title: AppStrings.openSettings.tr,paddingH: 10,paddingV: 10,onTab: (){

                            openAppSettings();

                          }),
                        ],
                      );

                    }
                  } else{
                    return Container();
                  }


                }),
            UiHelper.verticalSpaceSmall,


            FutureBuilder(
                initialData: PermissionStatus.denied,
                future: Permission.camera.status,
                builder: (bc,AsyncSnapshot<PermissionStatus>snapshot){

              if(snapshot.connectionState==ConnectionState.done) {

                if(snapshot.data==PermissionStatus.granted){
                  return Container();
                }
                else if(snapshot.data !=PermissionStatus.granted){
                  return Row(
                    children: [
                      Expanded(
                          flex:4,
                          child: Text(AppStrings.cameraPermissionRequired.tr,style: AppStyles.primaryStyle(bold: true,color: AppColors.red,fontSize: 15,height: 1.3),)),

                      Expanded(
                        child: Ui.primaryButton(title: AppStrings.allow.tr,paddingH: 10,paddingV: 10,marginV: 5,onTab: ()async{

                          await  Permission.camera.request();

                          if( !(await Permission.camera.request().isGranted)){
                          openAppSettings();}

                        }),
                      ),
                    ],
                  );

                }
                else {
                  return Column(
                    children: [
                      Text(AppStrings.cameraPermissionRequired.tr,style: AppStyles.primaryStyle(bold: true,color: AppColors.red,fontSize: 15,height: 1.3),),

                      Ui.primaryButton(title: AppStrings.openSettings.tr,paddingH: 10,paddingV: 10,onTab: (){

                        openAppSettings();

                      }),
                    ],
                  );

                }
              } else{
                return Container();
              }


            }),

            // UiHelper.verticalSpaceMedium,
            UiHelper.verticalSpaceMedium,
            if (logic.currentRequest != null)
              if (logic.currentRequest!.status == 'ready')
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColorOpacity,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppStrings.doctorReadyToStart.tr,
                          textAlign: TextAlign.center,
                          style: AppStyles.primaryStyle(
                              fontSize: 18, bold: false, height: 1.5),
                        ),
                      )
                    ],
                  ),
                ),
            UiHelper.verticalSpaceMedium,
            if (logic.currentRequest != null)
              if (logic.currentRequest!.status == 'in_process')
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: Lottie.asset(AppAnim.swipeUp,
                          width: 60.w
                          //Get.width*.2,
                          ,
                          height: 70.h),
                    ),

                    GestureDetector(
                      onTap: () {
                        logic.startMeeting();
                      },
                      child: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          radius: 29.h,
                          child: SvgPicture.asset(
                            AppImages.videoCall,
                            color: AppColors.white,
                            width: 30.w,
                            height: 30.h,
                          )),
                    ),
                    UiHelper.verticalSpaceLarge,
                    Text(
                      AppStrings.swipeUpToStart.tr,
                      style: AppStyles.primaryStyle(fontSize: 15),
                    ),
                    UiHelper.verticalSpaceLarge,

                    //         Ui.primaryButton(title: AppStrings.startMeeting, onTab: () {
                    //
                    //         if(!logic.noInternetConnection()) {
                    //           var appointment = Appointment(
                    //               appointmentDate: DateTime.now(),
                    //               doctor: logic.currentRequest!.name,
                    //
                    //               videoLink: logic.currentRequest!.jitsiLink);
                    //
                    //           Get.toNamed(AppRouteNames.meetingPage,arguments: appointment);
                    //           //   Get.toNamed(AppRouteNames.prescription, arguments: appointment);
                    //         }
                    //         else{
                    //           logic.buildFailedSnackBar(msg: AppStrings.checkInternet.tr);
                    //         }
                    // }),
                  ],
                ),
          ],
        ),
      );
    });
  }
}
