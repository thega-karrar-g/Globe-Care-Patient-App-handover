import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme_helper/app_colors.dart';

class AuthUi {
  static final double paddingHeight = 15.h;

  static OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.white.withOpacity(0.6)),
  );

  static BoxDecoration btnBoxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(30), color: AppColors.white);
}
