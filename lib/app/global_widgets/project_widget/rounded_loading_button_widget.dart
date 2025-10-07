import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../../base_controller/helpers_methods.dart';

class RoundedLoadingButtonWidget extends StatelessWidget {
  final RoundedLoadingButtonController btnController;
  final String text;
  final double? width;
  final VoidCallback onPressed;
  final Color? btnColor;
  final double? radius;

  const RoundedLoadingButtonWidget({
    Key? key,
    required this.btnController,
    required this.text,
    required this.onPressed,
    this.width,
    this.btnColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: btnController,
      animateOnTap: false,
      width: width ?? 1.sw,
      color: btnColor ?? Get.theme.primaryColor,
      borderRadius: radius ?? 8.0,
      successColor: Colors.green,
      onPressed: onPressed,
      child: Text(
        text,
        style:AppStyles.primaryStyle(
          color: HelpersMethod.getColorBasedOnItsBackgroundColor(
            btnColor ?? Get.theme.primaryColor,
          ),
          bold: true,
        ),
      ),
    );
  }
}
