import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';

class WeekItem extends StatelessWidget {
  WeekItem(
      {Key? key, this.weekName, this.weekNo, this.selected = false, this.onTab})
      : super(key: key);

  final String? weekName, weekNo;
  final bool selected;
  final Function? onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab!();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 11.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.h),
                      //   border: Border.all(color: selected?AppColors.primaryColorGreen:AppColors.primaryColorGreen.withOpacity(.5))
                      //   ,
                      color: selected
                          ? AppColors.primaryColorGreen
                          : AppColors.primaryColorGreen.withOpacity(.5)),
                  child: Text(
                    '$weekNo',
                    style: AppStyles.whiteStyle(bold: true),
                  ),
                ),
              ),
            ),
            Container(
              width: 48.w,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.h),
                  border: Border.all(
                      color: selected
                          ? AppColors.primaryColor
                          : AppColors.subTitleColor),
                  color: selected ? AppColors.primaryColor : AppColors.white),
              child: Text(
                '$weekName',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: selected
                    ? AppStyles.whiteStyle(bold: true, size: 16)
                    : AppStyles.subTitleStyle(bold: true, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
