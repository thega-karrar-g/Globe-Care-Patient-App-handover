import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';

class DrawerLinkWidget extends StatelessWidget {
  final String icon;
  final String text, subtitle;
  final VoidCallback onTap;

  DrawerLinkWidget({
    Key? key,
    required this.icon,
    required this.text,
    this.subtitle = '',
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0),
            decoration: BoxDecoration(
                color: AppColors.drawerItemColor.withOpacity(.30),
                borderRadius: BorderRadius.circular(8.h)),
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Row(
              children: [
                // Container(
                //      height: 45,
                //   width: 45,
                //     margin: EdgeInsets.symmetric(horizontal: 10),
                //
                //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: AppColors.primaryColor.withAlpha(45),
                //   ),
                //   child: SvgPicture.asset(
                //     icon,
                //     height: 25,
                //     width: 25,
                //     color: AppColors.primaryColor,
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 12),
                //   width: 1,
                //   height: 24,
                //   //  color: Get.theme.focusColor.withOpacity(0.2),
                // ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text.tr,
                        style: AppStyles.whiteStyle(bold: true, size: 12),
                        textAlign: TextAlign.start,
                      ),
                      // Text(subtitle.tr, style: Get.textTheme.bodyText2!.merge(TextStyle(fontSize: 10))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
              right: Get.locale.toString() == 'ar' ? 0 : -5.w,
              left: Get.locale.toString() == 'ar' ? -5.w : 0,
              child: Align(
                alignment: Get.locale.toString() == 'ar'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.h),
                      color: AppColors.primaryColor),
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 8.h,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryColor,
                      size: 13.w,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
