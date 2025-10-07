import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globcare/app/global_widgets/shared/my_appbar.dart';

import '../../../../core/assets_helper/app_images.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class ProfileRow extends StatelessWidget {
  const ProfileRow({Key? key, this.title, required this.iconData})
      : super(key: key);
  final String? title;
  final String iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          RotatedBox(
            quarterTurns:
            ar  && iconData==AppImages.phoneCall? 3:0,
            child: SvgPicture.asset(
              iconData,
              color: AppColors.primaryColorGreen,
              width: 15.w,
              height: 15.h,
            ),
          ),
          UiHelper.horizontalSpaceSmall,
          Expanded(
              child: Text(
            title!,
            style: AppStyles.primaryStyle(),
          ))
        ],
      ),
    );
  }
}
