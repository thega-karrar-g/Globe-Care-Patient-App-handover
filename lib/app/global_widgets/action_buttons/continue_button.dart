

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';

class  ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key,required this.function,required this.text
  }) : super(key: key);
  final Function() function;
  final String? text;



  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.ltr,
      child: InkWell(
        onTap: ()=>function(),
        child: SizedBox(
          height: 50.h,
          child:  Card(
          color: AppColors.primaryColor,
        shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(35.r),topLeft:
        Radius.circular(35.r))),

            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                  child: Row(
                    children: [
                      Text(text??AppStrings.submit.tr,
                      style:AppStyles.primaryStyle(fontSize: 15,bold: true,color: AppColors.white),),
                      const Spacer(),
                       Icon(
                        Icons.arrow_forward,
                        color:AppColors.white ,
                        size: 22.r,
                      )
                    ],
                  ).paddingSymmetric
                    (horizontal: 25.w,
                  vertical: 1.h),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
