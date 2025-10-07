import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../base_controller/base_controller.dart';
import '../../core/assets_helper/app_images.dart';
import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';
import '../../core/theme_helper/app_styles.dart';
import 'ui_helpers.dart';

class GlobcareSearch extends StatelessWidget {
  const GlobcareSearch({Key? key, required this.controller}) : super(key: key);
  final BaseController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColorOpacity,
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          Transform(
              transform: Matrix4.rotationY(
                  Get.locale.toString() == 'ar' ? math.pi : 0),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppImages.search,
                width: 20.w,
                height: 20.h,
                color: AppColors.primaryColor,
              )),
          UiHelper.horizontalSpaceMedium,
          Expanded(
            child: TextFormField(
              style: AppStyles.primaryStyle(),
              onChanged: (v) {
                controller.search(txt: v);
              },
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: AppStrings.search.tr,
                border: InputBorder.none,
                hintStyle: AppStyles.subTitleStyle(),
              ),
            ),
          ),
          UiHelper.horizontalSpaceMedium,
          if (controller.searchController.text.isNotEmpty)
            GestureDetector(
                onTap: () {
                  controller.searchController.clear();
                  controller.search();
                  controller.update();
                },
                child: Icon(
                  Icons.clear,
                  color: AppColors.primaryColorGreen,
                ))
        ],
      ),
    );
  }
}
