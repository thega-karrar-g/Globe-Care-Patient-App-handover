import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../base_controller/base_controller.dart';
import '../../core/assets_helper/app_images.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../modules/home_screen/home_screen_controller.dart';
import '../../routes/app_route_names.dart';

class NotificationBadgeWidget extends StatelessWidget {
  const NotificationBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed(
            AppRouteNames.notifications,
          );
        },
        //  onTap: ()=>Get.back(),
        child: GetBuilder<HomeScreenController>(
            id: 'NotificationUpdate',
            builder: (controller) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                AppImages.notification,
                width: 30.w,
                height: 30.h,
              ),

               if(BaseController.notificationCount>0)
              Positioned.fill(
                  top: 2.h,
                  right: -3.h,
                  left: 0,
                  child: Align(
                    alignment: Alignment.topRight,

                    child: Container(
                      width: 12.w,
                      height: 12.h,
                      padding: EdgeInsets.all(3.h),
                      decoration: BoxDecoration(

                          shape: BoxShape.circle,
                          color: AppColors.failedColor
                      ),
                      // child: Text('${BaseController.notificationCount}',
                      //   style: AppStyles.primaryStyle(
                      //       color: AppColors.white, fontSize: 10),),
                    ),
                  )),
            ],
          );
        }));
  }
}
