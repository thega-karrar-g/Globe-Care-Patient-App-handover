import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class DoctorDetailsItem extends StatelessWidget {
  const DoctorDetailsItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColorGreen),
                  ),
                ),
              ],
            ),
            UiHelper.horizontalSpaceSmall,
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        title.tr,
                        style: AppStyles.primaryStyle(bold: true, fontSize: 13),
                      )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        description,
                        style: AppStyles.primaryStyle(
                            bold: false, fontSize: 13, opacity: .7, height: 1.5),
                      )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
