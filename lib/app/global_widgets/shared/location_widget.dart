import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/language_and_localization/app_strings.dart';
import 'package:globcare/app/core/theme_helper/app_colors.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import 'package:globcare/app/global_widgets/shared/ui_helpers.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key,required this.address});

  final String address;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.location_on),
      UiHelper.horizontalSpaceTiny,
      Text(AppStrings.address.tr,style: AppStyles.primaryStyle(color: AppColors.white),),
      UiHelper.horizontalSpaceMedium,
      Text(address,style: AppStyles.primaryStyle(color: AppColors.white),),


    ],);
  }
}
