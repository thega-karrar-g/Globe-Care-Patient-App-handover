import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:globcare/app/core/assets_helper/app_images.dart';
import 'package:globcare/app/global_widgets/shared/different_dialogs.dart';
import 'package:intl/intl.dart' as intl;

import '../../../core/theme_helper/app_colors.dart';
import '../../../core/theme_helper/app_styles.dart';
import '../../../data/models/notification_model.dart';
import '../../../global_widgets/shared/ui_helpers.dart';
import '../../../global_widgets/ui.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key,required this.notificationModel,required this.onTab});
  final NotificationModel notificationModel;

  final  Function onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // print("****************");
        // print(notificationModel.id);
DifferentDialog.showNotificationReadDialog(
    image: notificationModel.imageUrl,
    title:UiHelper.isArabic ? notificationModel.nameAr :  notificationModel.nameEn,
    msg:UiHelper.isArabic ? notificationModel.bodyAr :  notificationModel.bodyEn,

);
       onTab();


      },
      child: Container(
        decoration: BoxDecoration(
          color: notificationModel.read || notificationModel.type =='public' ?AppColors.white: AppColors.appointmentBG,
          borderRadius: BorderRadius.circular(1.r)
        ),
        // color: AppColors.appointmentBG,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
        child: Row(
          children: [
            Ui.circularImg(url: notificationModel.imageUrl, margin: 0,errorImg: AppImages.logoOnly),
            UiHelper.horizontalSpaceMedium,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                        text:UiHelper.isArabic ? notificationModel.nameAr :  notificationModel.nameEn,
                        style: AppStyles.primaryStyle(bold: true, fontSize: 14),
                        children: [
                          TextSpan(text: '\t'),
                          // TextSpan(
                          //     text:UiHelper.isArabic?notificationModel.bodyAr: notificationModel.bodyEn,
                          //     style: AppStyles.subTitleStyle())
                        ]),
                  ),
                  UiHelper.verticalSpaceTiny,

                  // Text(UiHelper.isArabic?notificationModel.bodyAr: notificationModel.bodyEn,
                  //     style: AppStyles.subTitleStyle()),
                  UiHelper.verticalSpaceSmall,
                  Text(
                    intl. DateFormat('yyyy MMM dd hh:mm a').format(notificationModel.date) ,
                    style: AppStyles.subTitleStyle(bold: true),

                  ),
                  Divider(
                    color: notificationModel.read
                        ? AppColors.subTitleColor.withValues(alpha: .5)
                        : AppColors.primaryColor.withValues(alpha: .2),
                    thickness: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
