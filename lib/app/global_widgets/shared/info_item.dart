import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme_helper/app_colors.dart';
import '../ui.dart';
import 'ui_helpers.dart';
class InfoItem extends StatelessWidget {
  const InfoItem({Key? key,this.title='',this.child}) : super(key: key);

  final String title;
 final Widget? child;
  @override
  Widget build(BuildContext context) {
    return               Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          color: AppColors.primaryColorOpacity,


          borderRadius: BorderRadius.circular(10)),
      child: Column(children: [

        Row(children: [
          UiHelper.horizontalSpaceSmall,

          Ui.titleGreenUnderLine(title.tr, fontSize: 15,bottomPadding: 5)

        ],),

child??Container()

      ],),
    )
    ;
  }
}
