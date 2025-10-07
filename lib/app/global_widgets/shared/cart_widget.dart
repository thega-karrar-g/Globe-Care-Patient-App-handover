import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/assets_helper/app_images.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';

import '../../modules/home_screen/home_screen_controller.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (controller) {
      return SvgPicture.asset(AppImages.medicalCart,colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),);
    });
  }
}
