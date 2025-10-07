import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../core/assets_helper/app_images.dart';
import 'dynamic_column.dart';
import 'ui_helpers.dart';

class NoAppointmentTimes extends StatelessWidget {
  const NoAppointmentTimes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: DynamicColumn(
          // mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: SvgPicture.asset(
                AppImages.noAppointment,
                width: Get.width * .7,
                height: Get.height * .3,
              ),
            ),
            UiHelper.verticalSpaceLarge,
            Text(
              AppStrings.oops.tr,
              style: AppStyles.primaryStyle(fontSize: 30),
            ),
            UiHelper.verticalSpaceSmall,
            Text(
              AppStrings.noAppointment.tr,
              textAlign: TextAlign.center,
              style: AppStyles.primaryStyle(fontSize: 15, opacity: .7, height: 1.7),
            ),
          ],
        ),
      ),
    );
  }
}
