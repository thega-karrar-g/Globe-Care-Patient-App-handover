import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_fonts.dart';
import '../../../../global_widgets/shared/loading.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/ui.dart';
import 'pcr_services_logic.dart';
import 'widgets/pcr_item.dart';

class PCRServicesPage extends StatelessWidget {
  final PCRServicesLogic logic = Get.put(PCRServicesLogic());

  PCRServicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PCRServicesLogic>(builder: (logic) {
      return Ui.myScaffold(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myAppBar2(title: AppStrings.pcrService),
          logic.busy
              ? Center(
                  child: MyLoadingWidget(),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: logic.items.length,
                      itemBuilder: (bc, index) => GestureDetector(
                            onTap: () {
                              //logic.updateItems(logic.items[index]);
                            },
                          //   child: PCRItem(pcrModel: logic.items[index],logic: logic,selected: true,)
                          )),
                ),
        ],
      ));
    });
  }

  TextStyle customTStyle(
      {double size = 14, isBold = false, Color color = AppColors.black}) {
    return TextStyle(
        color: color.withOpacity(.8),
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontFamily: AppFonts.mainFontFamily);
  }
}
