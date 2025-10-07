import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../data/models/user_model.dart';

class PatientItem extends StatelessWidget {
  const PatientItem({Key? key, required this.user, required this.selected})
      : super(key: key);

  final AppUser user;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    var n = '';
    if (user.name.trim().split(' ').length > 1) {
      n = '${user.name.trim().split(' ')[0]}\t${user.name.trim().split(' ').last}';
    } else {
      n = user.name.trim().split(' ')[0];
    }

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color:
              selected ? AppColors.primaryColor : AppColors.primaryColorOpacity,
          border: Border.all(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(5.h)),
      width: 80.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  n,
                  textAlign: TextAlign.center,
                  style: selected
                      ? AppStyles.whiteStyle(size: 12, height: 1.3, bold: true)
                      : AppStyles.primaryStyle(
                          bold: false, fontSize: 12, height: 1.3),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
