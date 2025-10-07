import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';


class ActionButton extends StatelessWidget {
  final String? text;
  final Widget? childWidget;
  final double height;
  final double? paddingH,paddingV;
  final double? fontHeight;
  final double radius;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final RoundedLoadingButtonController? btnController;

  const ActionButton({
    Key? key,
    this.text,
    this.backgroundColor,
    this.textColor,
    required this.onPressed,
    this.btnController,
    this.height = 50,
    this.childWidget,
    this.fontSize,
    this.radius = 16.0,
    this.fontHeight = 1,
    this.paddingH,this.paddingV
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return btnController != null
        ? RoundedLoadingButton(
            controller: btnController!,
            animateOnTap: false,
            width: Get.width,
            height: height.h,
            color: backgroundColor ?? Get.theme.colorScheme.primary,
            borderRadius: radius,
            successColor: Colors.green,
            elevation: 0,
            onPressed: onPressed,
            child: childWidget ??
                Text(
                  text ?? AppStrings.submit.tr.capitalizeFirst!,
                  style: AppStyles.primaryStyle(color: textColor??AppColors.white,fontSize: fontSize ?? 14),
                ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            clipBehavior: Clip.antiAlias,
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                Size(double.infinity, height.h),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: paddingH?.w ?? 8.w,vertical: paddingV?.h ?? 8.h),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                backgroundColor ?? Get.theme.colorScheme.primary,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(radius),
                  ),
                ),
              ),
              elevation: MaterialStateProperty.all<double>(0),
            ),
            child: childWidget ??
                Text(
                  text ?? AppStrings.submit.tr.capitalizeFirst!,
                    style: AppStyles.primaryStyle(color: textColor??AppColors.white,bold: true,fontSize: fontSize??14),

                ),
          );
  }
}
