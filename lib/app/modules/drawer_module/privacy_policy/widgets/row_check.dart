import 'package:flutter/material.dart';

import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/ui_helpers.dart';

class RowCheck extends StatelessWidget {
  const RowCheck({
    Key? key,
    required this.title,
    required this.checked,
    this.onTab,
  }) : super(key: key);

  final bool checked;
  final Function? onTab;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTab != null) {
          onTab!();
        }
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: checked ? AppColors.primaryColorGreen : AppColors.white,
                border: Border.all(
                    color: checked
                        ? AppColors.primaryColorGreen
                        : AppColors.subTitleColor)),
            child: Icon(Icons.check, color: AppColors.white),
          ),
          UiHelper.horizontalSpaceSmall,
          Expanded(
              child: Text(
            title,
            style: checked
                ? AppStyles.primaryStyleGreen()
                : AppStyles.subTitleStyle(),
          ))
        ],
      ),
    );
  }
}
