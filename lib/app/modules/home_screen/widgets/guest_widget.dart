
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/global_widgets/ui.dart';

import '../../../core/language_and_localization/app_strings.dart';
import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/constants/booking_constants.dart';
import '../../../routes/app_route_names.dart';

class GuestWidget extends StatelessWidget {
  const GuestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      decoration: BoxDecoration(
          color: AppColors.primaryColorOpacity,
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(
          vertical: 15.h, horizontal: 20.w),
      child: Row(
        children: [
          Expanded(
              child: Text.rich(TextSpan(
                  text: AppStrings.guest2.tr,
                  style: AppStyles.primaryStyle(
                      fontSize: 13, opacity: .7, height: 1.5),
                  children: [
                    TextSpan(text: '\t'),



                    WidgetSpan(child: Padding(
                      padding:  EdgeInsets.only(top: 5.h),
                      child: Ui.primaryButton(title:AppStrings.logIn.tr,

                          fontSize: 12,
                          paddingH: 10,
                          paddingV: 10,
                          marginV: 3,

                          onTab: (){

                        BookingConstants.fromPatientData = null;

                        Get.toNamed(AppRouteNames.login);

                      } ),
                    )),

                    // TextSpan(
                    //     text: AppStrings.logIn.tr,
                    //     style: AppStyles.primaryStyle(
                    //         bold: true, size: 14),
                    //     recognizer: TapGestureRecognizer()
                    //       ..onTap = () {
                    //
                    //       })
                  ]))),
        ],
      ),
    );
  }
}
