import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/nurse_service.dart';
import '../../../../global_widgets/shared/different_dialogs.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class ServiceItem extends StatelessWidget {
  ServiceItem({Key? key, this.nurseService, this.selected = false})
      : super(key: key);

  NurseService? nurseService;
  bool selected;
  bool ar = Get.locale.toString() == 'ar';

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        color: AppColors.primaryColorOpacity,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 25.w,
              height: 100.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.primaryColorGreen,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ar ? 15.h : 0),
                    bottomRight: Radius.circular(ar ? 15.h : 0),
                    bottomLeft: Radius.circular(ar ? 0 : 15.h),
                    topLeft: Radius.circular(ar ? 0 : 15.h),
                  )),
              child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    '${nurseService!.price}    ${AppStrings.currency.tr}',
                    style: AppStyles.whiteStyle(size: 12, bold: true),
                  )),
            ),
            UiHelper.horizontalSpaceSmall,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  UiHelper.verticalSpaceTiny,
                    Text(
                      ar ? nurseService!.nameAr : nurseService!.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.primaryStyle(
                          bold: true, fontSize: 12, height: 1.5),
                    ),
                    //  UiHelper.verticalSpaceSmall,
                    UiHelper.verticalSpaceTiny,

                    Text(
                      ar
                          ? nurseService!.descriptionAr
                          : nurseService!.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.primaryStyle(
                          bold: false, fontSize: 12, height: 1.5, opacity: .9),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Spacer(),
                UiHelper.verticalSpaceTiny,
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primaryColorGreen
                          : AppColors.primaryColorOpacity,
                      border: Border.all(
                          color: selected
                              ? AppColors.white
                              : AppColors.subTitleColor),
                      borderRadius: BorderRadius.circular(5.h)),
                  child: Icon(
                    Icons.check,
                    size: 17.w,
                    color: selected
                        ? AppColors.white
                        : AppColors.primaryColorOpacity,
                  ),
                ),
                Spacer(),
                UiHelper.verticalSpaceTiny,
                GestureDetector(
                  onTap: () {
                    DifferentDialog.nurseBottomSheet(
                        serviceName:
                            ar ? nurseService!.nameAr : nurseService!.name,
                        desc: ar
                            ? nurseService!.descriptionAr
                            : nurseService!.description,
                        instructions: ar
                            ? nurseService!.instructionsAr
                            : nurseService!.instructions);
                  },
                  child: Container(
                    height: 35.h,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(ar ? 0 : 15.h),
                          topLeft: Radius.circular(ar ? 0 : 15.h),
                          topRight: Radius.circular(ar ? 15.h : 0),
                          bottomLeft: Radius.circular(ar ? 15.h : 0),
                        )),
                    child: Text(
                      AppStrings.showMore.tr,
                      style: AppStyles.whiteStyle(bold: true, size: 11),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
