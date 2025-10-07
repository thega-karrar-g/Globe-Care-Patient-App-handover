import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future buildBottomSheet({
  required Widget widget,
  EdgeInsets? padding,
  Color? backgroundColor,
  double radius = 16.0,
}) {
  ScreenUtil().bottomBarHeight;
  return Get.bottomSheet(
    SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 1.sh - ScreenUtil().bottomBarHeight,
        ),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: widget,
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius),
        topLeft: Radius.circular(radius),
        // bottomRight: Radius.circular(16.0),
        // bottomLeft: Radius.circular(16.0),
      ),
    ),
    clipBehavior: Clip.antiAlias,
    backgroundColor: backgroundColor ?? Colors.white,
    isDismissible: true,
    // persistent: false,
    // ignoreSafeArea: true,
    enableDrag: true,
    isScrollControlled: true,
  );
}
