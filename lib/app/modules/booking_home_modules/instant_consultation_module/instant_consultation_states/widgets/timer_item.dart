import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../../../../../core/assets_helper/app_anim.dart';
import '../instant_consultation_states_logic.dart';

class TimerItem extends StatelessWidget {
  const TimerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isAr = Get.locale.toString() == 'ar';
    return GetBuilder<InstantConsultationStatesLogic>(builder: (logic) {
      return DynamicColumn(
        children: [
          UiHelper.verticalSpaceMedium,

          // Text(AppStrings.instantConsRequestSendMsg.tr, textAlign: TextAlign.center,
          //   style: AppStyles.primaryStyle(height: 1.5,size: 16),),

//instantConsRequestSendMsg
          //   Image.asset(AppImages.iconTimer, width: 150, height: 150,),
          Row(
            children: [
              if (isAr) UiHelper.horizontalSpaceMassive,
              Expanded(
                  child: Lottie.asset(
                AppAnim.waitingClock,
                width: Get.width,
                height: Get.width * .6,
              )),
              if (!isAr) UiHelper.horizontalSpaceMassive,
            ],
          ),
          UiHelper.verticalSpaceMedium,

          Directionality(
            textDirection: TextDirection.rtl,
            child: SlideCountdown(
              key: logic.countDownKey,
              duration: logic.countDownDuration,
              countUp: false,
              separatorType: SeparatorType.symbol,
              slideDirection: SlideDirection.up,
              textDirection: TextDirection.rtl,
              durationTitle: DurationTitle.enShort(),
              showZeroValue: false,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 35.w),
              decoration: BoxDecoration(
                  color: AppColors.primaryColorGreen,
                  borderRadius: BorderRadius.circular(7)),
              onDone: () {
                logic.onCounterDownDone();
                // logic.timerFinished();
              },
            ),
          ),
          UiHelper.verticalSpaceMedium,

          Text(
            AppStrings.requestSendMsg.tr,
            textAlign: TextAlign.center,
            style: AppStyles.primaryStyle(height: 1.5, fontSize: 16),
          ),
        ],
      );
    });
  }
}
