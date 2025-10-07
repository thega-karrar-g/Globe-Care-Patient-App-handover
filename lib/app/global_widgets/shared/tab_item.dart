import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';

class TabItem extends StatelessWidget {
  const TabItem(
      {Key? key,
      required this.name,
      required this.onTab,
      this.selected = false,
      this.fontSize = 16.0})
      : super(key: key);
  final String name;
  final bool selected;
  final Function onTab;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTab();
        },
        behavior: HitTestBehavior.translucent,
        child: IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.h),
              color: selected ? AppColors.primaryColor:AppColors.primaryColorOpacity
            ),
            // color: AppColors.green,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(name.tr,
                          textAlign: TextAlign.center,
                          style: AppStyles.primaryStyle(
                              bold: true,
                              fontSize: fontSize,
                              color: selected
                                  ? AppColors.white
                                  : AppColors.primaryColor.withOpacity(.7))),
                    ),
                  ],
                ),
                // if (selected)
                //   Row(
                //     children: [
                //       Expanded(
                //           child: Container(
                //         margin: EdgeInsets.only(
                //           top: 5.h,
                //           bottom: 5.h,
                //         ),
                //         height: 5.h,
                //         decoration: BoxDecoration(
                //             color: AppColors.primaryColorGreen,
                //             borderRadius: BorderRadius.circular(5.h)),
                //       ))
                //     ],
                //   )
                // else
                //   Row(
                //     children: [
                //       Expanded(
                //           child: Container(
                //         margin: EdgeInsets.only(
                //           top: 5.h,
                //           bottom: 5.h,
                //         ),
                //         height: 3.h,
                //         decoration: BoxDecoration(
                //             color: AppColors.subTitleColor.withOpacity(.5),
                //             borderRadius: BorderRadius.circular(5.h)),
                //       ))
                //     ],
                //   )
              ],
            ),
          ),
        ));
  }
}
