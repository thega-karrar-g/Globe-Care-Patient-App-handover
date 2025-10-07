import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base_controller/base_controller.dart';
import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../data/models/home_service.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../booking_home_modules/service_details/service_details_logic.dart';

class AppointmentTypeItem extends StatelessWidget {
  AppointmentTypeItem({Key? key, this.homeService,required this.onTab}) : super(key: key);

  final HomeService? homeService;
  final double h = 80.h;
  final ar = Get.locale.toString() == 'ar';
final Function onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTab();

      },
      child: Container(
        // height: h,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
            color: AppColors.primaryColorOpacity,
            borderRadius: BorderRadius.circular(10.h)),
        child: Row(
          children: [
            UiHelper.horizontalSpaceMedium,
            Image.asset(
              homeService!.icon, height: h, width: 60.w,
              // color: AppColors.primaryColorGreen,
            ),
            UiHelper.horizontalSpaceMedium,
            Expanded(
                child: Column(
              children: [
                UiHelper.verticalSpaceMedium,
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      homeService!.name.tr,
                      style: AppStyles.primaryStyle(bold: true, fontSize: 12),
                    )),
                  ],
                ),
                UiHelper.verticalSpaceTiny,
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      '${AppStrings.show.tr} ${homeService!.description.tr}',
                      maxLines: 2,
                      style: AppStyles.primaryStyle(
                          bold: false, fontSize: 10, opacity: .7),
                    )),
                  ],
                ),
              ],
            )),
            UiHelper.horizontalSpaceSmall,
            Container(
              alignment: Alignment.center,
              width: 30.w,
              height: h,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ar ? 0 : 10.h),
                    bottomRight: Radius.circular(ar ? 0 : 10.h),
                    topLeft: Radius.circular(ar ? 10.h : 0),
                    bottomLeft: Radius.circular(ar ? 10.h : 0),
                  )),
              child: CircleAvatar(
                radius: 10.h,
                backgroundColor: AppColors.white,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 15.w,
                  color: AppColors.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
