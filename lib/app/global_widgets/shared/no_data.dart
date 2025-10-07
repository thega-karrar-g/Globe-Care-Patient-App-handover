import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../core/assets_helper/app_anim.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound(
      {Key? key,
      this.animation = AppAnim.search,
      this.msg = AppStrings.noDataFound})
      : super(key: key);
  final String animation, msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: Get.height*.1,),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Lottie.asset(
                animation,
                width: Get.width * .5,
                height: Get.height * .25,
              ),
            ),
            //   UiHelper.verticalSpaceMedium,
            //     Text(AppStrings.oops.tr,style: AppStyles.primaryStyle(size: 25),),
            //     UiHelper.verticalSpaceSmall,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 5.h),
              child: Text(
                msg.tr,
                textAlign: TextAlign.center,
                style: AppStyles.primaryStyle(fontSize: 18, height: 1.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
