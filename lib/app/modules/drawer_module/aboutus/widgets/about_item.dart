import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/about_model.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class AboutItem extends StatelessWidget {
  const AboutItem({
    Key? key,
    this.aboutModel,
  }) : super(key: key);

  final AboutModel? aboutModel;

  @override
  Widget build(BuildContext context) {
    final ar = Get.locale.toString() == 'ar';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 4.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.h),
                        color: AppColors.primaryColorGreen),
                  ),
                ),
              ],
            ),
            UiHelper.horizontalSpaceSmall,
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        ar ? aboutModel!.titleAr : aboutModel!.titleEn,
                        style: AppStyles.primaryStyle(bold: true, fontSize: 16),
                      )),
                    ],
                  ),
                  UiHelper.verticalSpaceSmall,
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        ar
                            ? aboutModel!.descriptionAr
                            : aboutModel!.descriptionEn,
                        style: AppStyles.primaryStyle(
                            bold: false, fontSize: 13, opacity: .7, height: 1.5),
                      )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
