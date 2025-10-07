import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/assets_helper/app_images.dart';
import '../../../../../core/language_and_localization/app_strings.dart';
import '../../../../../core/theme_helper/app_colors.dart';
import '../../../../../core/theme_helper/app_styles.dart';
import '../../../../../global_widgets/shared/dynamic_column.dart';
import '../../../../../global_widgets/shared/ui_helpers.dart';
import '../instant_consultation_states_logic.dart'; // import this

class SendRequestAgain extends StatelessWidget {
  const SendRequestAgain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstantConsultationStatesLogic>(builder: (logic) {
      return DynamicColumn(
        children: [
          Image.asset(
            AppImages.iconTimer,
            width: 120,
            height: 120,
          ),
          UiHelper.verticalSpaceMedium,
          Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(7)),
              child: Text(
                '00:00',
                style: AppStyles.whiteStyle(bold: true),
              )),
          UiHelper.verticalSpaceMedium,
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: AppColors.primaryColorOpacity,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(
                  AppStrings.resendRequestMsg.tr,
                  style: AppStyles.primaryStyle(fontSize: 14, height: 1.5),
                )
              ],
            ),
          ),
          UiHelper.verticalSpaceLarge,
          GestureDetector(
            onTap: () {
//logic.sendRequest();
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    color: AppColors.primaryColorGreen,
                    borderRadius: BorderRadius.circular(7)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform(
                        transform: Matrix4.rotationY(
                            Get.locale.toString() == 'ar' ? 0 : math.pi),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.replay_rounded,
                          color: AppColors.white,
                        )),
                    UiHelper.horizontalSpaceSmall,
                    Text(
                      AppStrings.resendRequest.tr,
                      style: AppStyles.whiteStyle(bold: true),
                    ),
                  ],
                )),
          ),
        ],
      );
    });
  }
}
