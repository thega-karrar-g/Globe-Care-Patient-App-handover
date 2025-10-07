import 'package:dialog_loader/dialog_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/assets_helper/app_anim.dart';
import 'package:lottie/lottie.dart';

import '../../core/language_and_localization/app_strings.dart';
import '../../core/theme_helper/app_colors.dart';

class ShowLoader {
  static late DialogLoader _dialogLoader;

  Future<void> show() async {
    _dialogLoader = DialogLoader(context: Get.context);
    _dialogLoader.show(
      theme: LoaderTheme.dialogDefault,
      title: SizedBox(
       // height: 150,
        width: Get.mediaQuery.size.width / 2,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  //Get.offAllNamed(AppRouteNames.home);

                  // Get.back();
                },
                child: Lottie.asset(
                  AppAnim.paymentLoading,
                  width: Get.width * .2,
                  height: Get.width * .2,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              AppStrings.paymentLoading.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.subTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      avatarRadius: 0
    );
  }

  void update(String title, IconData leftIcon, {Color colors = Colors.black87}) {
    _dialogLoader.update(
      title: SizedBox(
        // height: 150,
        width: Get.mediaQuery.size.width / 2,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  //Get.offAllNamed(AppRouteNames.home);

                  // Get.back();
                },
                child: Lottie.asset(
                  AppAnim.paymentLoading,
                  width: Get.width * .2,
                  height: Get.width * .2,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              AppStrings.paymentLoading.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.subTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      avatarRadius: 0,
      autoClose: true,
      barrierDismissible: true,
    );
  }
}