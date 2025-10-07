import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/base_controller/base_controller.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/utils/string_reverse.dart';
import 'package:lottie/lottie.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_styles.dart';
import '../../global_widgets/shared/my_appbar.dart';
import '../../global_widgets/shared/tab_item.dart';
import '../../global_widgets/shared/ui_helpers.dart';
import '../../core/assets_helper/app_anim.dart';
import '../drawer_module/drawer_widget/main_drawer_widget.dart';
import 'notifications_logic.dart';
import 'widgets/empty_notification.dart';
import 'widgets/notification_item.dart';

class NotificationsPage extends StatelessWidget {
  final logic = Get.find<NotificationsLogic>();

  NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerWidget(),
      body: GetBuilder<NotificationsLogic>(builder: (controller) {
        return Column(
          children: [
            Padding(
              padding:UiHelper.safeAreaPadding,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: myAppBar2(title: AppStrings.notifications,

                      //     actionBesideTitle: BaseController.notificationCount > 0 ? GestureDetector(
                      //   onTap: (){
                      //
                      //     controller.markAllRead();
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
                      //     decoration: BoxDecoration(color: AppColors.primaryColor,borderRadius: BorderRadius.circular(5.r)),
                      //
                      //     child: Text(AppStrings.markAllRead.tr,style: AppStyles.primaryStyle(color: AppColors.white,fontSize: 10),),
                      //
                      //   ),
                      // ) :SizedBox()
                      )),
                      // UiHelper.horizontalSpaceSmall,

                    ],
                  ),

                  UiHelper.verticalSpaceSmall,
                  Row(children: [

                    Expanded(
                      child: TabItem(
                          name: AppStrings.private.tr,
                          fontSize: 16,
                          selected: controller.isPrivateSelected,
                          onTab: () {
                            controller.updateType(true);
                          }),
                    ),
                    UiHelper.horizontalSpaceSmall,
                    Expanded(
                      child: TabItem(
                          name: AppStrings.public.tr,
                          fontSize: 16,
                          selected: !controller.isPrivateSelected,
                          onTab: () {
                            controller.updateType(false);
                          }),
                    ),
                  ],),
                ],
              ),
            ),

            UiHelper.verticalSpaceMedium,


            Expanded(child:
            logic.busy ? Center(child: UiHelper.spinKitProgressIndicator()) :

            logic.currentNotifications.isEmpty ? EmptyNotification() :
            Container(
              decoration: BoxDecoration(
                // color: AppColors.appointmentBG
              ),
              child: ListView.builder(
                  itemCount: logic.currentNotifications.length,
                  itemBuilder: (bc, index) =>
                      NotificationItem(notificationModel: logic
                          .currentNotifications[index],onTab: (){
                        print("********");
                       logic.readNotification(logic.currentNotifications[index].id,index);
                        },
                      )
              // GestureDetector(
              //   onTap: (){
              //     print("**********");
              //     },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(" Notification ${logic.currentNotifications[index].id}"),
              //   ),
              // )
              ),
            ))
          ],
        );
      }),
    );
  }
}
