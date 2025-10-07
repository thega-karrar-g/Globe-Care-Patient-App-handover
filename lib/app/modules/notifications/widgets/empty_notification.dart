import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/assets_helper/app_anim.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../global_widgets/shared/ui_helpers.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
UiHelper.verticalSpace(100),
        LottieBuilder.asset(
          AppAnim.noNotification,
          width: Get.width * .7,
          height: Get.height * .25,
        ),


        Text(
          AppStrings.oops.tr,
          style: AppStyles.primaryStyle(bold: true, fontSize: 25),
        ),
        UiHelper.verticalSpaceSmall,
        Text(
          AppStrings.noNotifications.tr,
          style:
          AppStyles.primaryStyle(bold: false, fontSize: 18),
        ),
        // UiHelper.verticalSpaceLarge,
      ],
    );
  }
}
