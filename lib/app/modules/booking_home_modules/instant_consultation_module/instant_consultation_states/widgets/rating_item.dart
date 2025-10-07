import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../core/assets_helper/app_images.dart';
import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../global_widgets/ui.dart';
import '../instant_consultation_states_logic.dart';

class RatingItem extends StatelessWidget {
  const RatingItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InstantConsultationStatesLogic.rate = '';
double iconSize=50;
    return GetBuilder<InstantConsultationStatesLogic>(builder: (logic) {
      return SingleChildScrollView(
        child: DynamicColumn(
          children: [
            UiHelper.verticalSpaceMassive,
            UiHelper.verticalSpaceMassive,

            // if(logic.currentRequest !=null)
            // if(logic.currentRequest!.status=='evaluation')
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              decoration: BoxDecoration(
                  color: AppColors.primaryColorOpacity,
                  borderRadius: BorderRadius.circular(10.h)),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                decoration: BoxDecoration(
                    color: AppColors.primaryColorOpacity,
                    borderRadius: BorderRadius.circular(10.h)),
                child: Column(
                  children: [
                    // Row(children: [
                    //
                    //   Expanded(
                    //     child: Text(AppStrings.rateThankMsg.tr,
                    //       textAlign: TextAlign.center,
                    //       style: AppStyles.primaryStyle(size: 15,bold: false, height: 1.5),),
                    //   )
                    //
                    //
                    // ],),
                    UiHelper.verticalSpaceSmall,
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStrings.rateInstantConsMsg.tr,
                            textAlign: TextAlign.center,
                            style: AppStyles.primaryStyle(
                                fontSize: 18, bold: false, height: 1.5),
                          ),
                        )
                      ],
                    ),

                    UiHelper.verticalSpaceLarge,

                    SizedBox(
                     // height: 100.h,
                      child: RatingBar(
                        initialRating: 1,

                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        unratedColor: AppColors.primaryColor.withOpacity(.2),
                        itemPadding: EdgeInsets.symmetric(horizontal: 5.w),
                        itemSize: iconSize.sp,
                        ratingWidget: RatingWidget(
                          full: SvgPicture.asset(
                            AppImages.starFill,
                            color: AppColors.primaryColor,
                            width: iconSize.w,
                            height: iconSize.h,
                            fit: BoxFit.fill,
                          ),
                          half: SvgPicture.asset(
                            AppImages.starOutline,
                            color: AppColors.primaryColor,
                            width: iconSize.w,
                            height: iconSize.h,
                          ),
                          empty: SvgPicture.asset(
                            AppImages.starOutline,
                            color: AppColors.primaryColor,
                            width: iconSize.w,
                            height: iconSize.h,
                          ),
                        ),

                        onRatingUpdate: (rating) {
                          if (rating == 0) {
                            InstantConsultationStatesLogic.rate = '';
                          } else {
                            InstantConsultationStatesLogic.rate =
                                rating.toInt().toString();
                          }


                        },
                        updateOnDrag: false,
                        //tapOnlyMode: true,
                      ),
                    ),

                    UiHelper.verticalSpaceLarge,
                    Row(
                      children: [
                        Expanded(
                            child: Ui.primaryButton(
                                title: AppStrings.send,
                                marginV: 5,
                                paddingV: 10,
                                fontSize: 15,
                                onTab: () {

                              //    logic.logger.i(' *************************    ${InstantConsultationStatesLogic.rate} ');

                                  if (InstantConsultationStatesLogic
                                      .rate.isNotEmpty) {
                                    logic.rateConsultation();
                                  } else {
                                    logic.buildFailedSnackBar(
                                        msg: AppStrings
                                            .rateInstantConsErrMsg.tr);
                                  }
                                })),
                        // UiHelper.horizontalSpaceMedium,
                        // Expanded(child: Ui.primaryButtonOutlined(title: AppStrings.notNow,marginV: 5,fontSize: 15,paddingV: 10,color: AppColors.primaryColorOpacity,onTab: (){
                        //   InstantConsultationLogic.rate='';
                        //   logic.rateConsultation();
                        //
                        // }))
                      ],
                    )
                  ],
                ),
              ),
            ),

            UiHelper.verticalSpaceMedium,
          ],
        ),
      );
    });
  }
}
