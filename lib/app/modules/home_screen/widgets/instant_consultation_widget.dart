import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:im_animations/im_animations.dart';
import 'dart:math' as math; // import this

import '../../../core/assets_helper/app_images.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';
import '../../booking_home_modules/instant_consultation_module/instant_consultation_states/instant_consultation_states_logic.dart';

class InstantConsultationWidget extends StatelessWidget {
  const InstantConsultationWidget({Key? key, this.onTab}) : super(key: key);

  final Function? onTab;

  @override
  Widget build(BuildContext context) {
    double height = 100;
    return GetBuilder<InstantConsultationStatesLogic>(
        builder: (logic) {
      return Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [


            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  onTab!();
                },
                child: Container(
                  height: height.h,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor
                          .withOpacity(.1),
                      borderRadius: BorderRadius.circular(5.h)),
                  padding: EdgeInsets.symmetric(
                      vertical: 5.h, horizontal: 30),
                  // margin: EdgeInsets.symmetric(vertical: 0.h,horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 5.w),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                            AppStrings
                                                .instantConsultation.tr,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style:
                                            AppStyles.primaryStyle(
                                                fontSize: 11,
                                                bold: true,
                                                color: AppColors
                                                    .primaryColor),
                                          )),
                                    ],
                                  ),
                                ),


                                if(logic.currentRequest ==null)
                                Ui.primaryButton(
                                    title: AppStrings.bookNow,
                                    paddingV: 5,
                                    color:
                                    AppColors.primaryColorGreen,
                                    fontSize: 11,
                                    marginH: 3,
                                    marginV: 0,
                                    radius: 5,
                                    onTab: () {


                                      onTab!();



                                    })


                                else Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColors.primaryColor
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                      Text(getButtonText(logic).tr,style: AppStyles.primaryStyle(color: AppColors.white),),

                                      UiHelper.horizontalSpaceSmall,

                                      SpinKitThreeBounce(color: AppColors.white,size: 20.r,)

                                    ],))
                                ,

                                UiHelper.verticalSpaceSmall,
                              ],
                            ),
                          )),
                      UiHelper.horizontalSpaceMedium,
                      Container(
                        // height: height.h,
                        width: 70.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Transform(
                          transform: Matrix4.rotationY(
                              Get.locale.toString() == 'ar'
                                  ? 0
                                  : math.pi),
                          alignment: Alignment.center,
                          child: ColorSonar(
//                           waveColor: AppColors.primaryColor,
//                           waveThickness: 1.3,
//                           radius: 70,
// insets: 0,

                            contentAreaRadius: 13.h,
                            waveFall: 11.h,
                            waveMotionEffect: Curves.elasticInOut,
                            waveMotion: WaveMotion.smooth,
                            duration: Duration(seconds: 1),

                            contentAreaColor: AppColors.primaryColor
                                .withOpacity(.2),
                            outerWaveColor: AppColors.primaryColor.withOpacity(
                                .2),
                            innerWaveColor: AppColors.primaryColor.withOpacity(
                                .2),
                            middleWaveColor: AppColors.primaryColor.withOpacity(
                                .2),


                            //  waveThickness: 2,
                            child: Image.asset(
                              AppImages.iconCallDoctor,
                              // fit: BoxFit.fill,
                              width: 100.w, height: (height - 20).h,
                              // colorBlendMode: BlendMode.color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // UiHelper.horizontalSpaceMedium,
            // Expanded(child:  CallUsWidget(),),
          ],
        ),
      );
    });
  }


 String getButtonText( InstantConsultationStatesLogic logic ){


    if(logic.currentRequest !=null) {
      switch (logic.currentRequest!.status) {

        case "ready":{  return AppStrings.startMeeting; }
        case "approved":{  return AppStrings.payNow; }
        case "waiting":{  return AppStrings.waiting; }
        case "evaluation":{  return AppStrings.rating; }
        case "in_process":{  return AppStrings.joinMeeting; }

        default :{
          return AppStrings.bookNow;
        }



      }
    }
    return AppStrings.bookNow;

 }


}
