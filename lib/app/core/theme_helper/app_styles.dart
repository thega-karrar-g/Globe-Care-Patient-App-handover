import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppStyles {
  AppStyles._();

  static primaryStyle(
      {bool bold = false,
      double fontSize = 13,
      bool lineThrough = false,
        TextDecoration textDecoration=TextDecoration.none,
      double opacity = 1.0,
      double height = 0.0,
      Color color = AppColors.primaryColor,Color lineThroughColor=AppColors.textColorLight}) {
    return TextStyle(
        fontSize: fontSize.sp,
        color: color.withOpacity(opacity),
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontFamily: AppFonts.mainFontFamily,
        height: height > 0 ? height : null,
        decorationColor: lineThroughColor,
        decoration:
            textDecoration);
  }

  static primaryStyleGreen(
      {bool bold = false, double size = 13, double height = 0.0}) {
    return TextStyle(
        fontSize: size.sp,
        color: AppColors.primaryColorGreen,
        fontFamily: AppFonts.mainFontFamily,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        height: height > 0 ? height.h : null);
  }

  static whiteStyle(
      {bool bold = false,
      double size = 13,
      double opacity = 1.0,
      double height = 0.0}) {
    return TextStyle(
        fontSize: size.sp,
        color: AppColors.white.withOpacity(opacity),
        fontFamily: AppFonts.mainFontFamily,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        height: height > 0 ? height.h : null);
  }

  static subTitleStyle(
      {bool bold = false, double size = 13, double height = 0.0}) {
    return TextStyle(
        fontSize: size.sp,
        color: AppColors.primaryColor.withOpacity(.9),
        fontFamily: AppFonts.mainFontFamily,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        height: height > 0 ? height.h : null);
  }

  static subTitleStyleDark(
      {bool bold = false, double size = 13, double height = 0.0}) {
    return TextStyle(
        fontSize: size.sp,
        color: AppColors.subTitleColor2,
        fontFamily: AppFonts.mainFontFamily,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        height: height > 0 ? height.h : null);
  }

  static weekStyle({bool bold = false, double size = 13}) {
    return TextStyle(
        fontSize: size.sp,
        color: AppColors.subTitleColor,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal);
  }
}
