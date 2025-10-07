import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/language_and_localization/app_strings.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../core/theme_helper/app_fonts.dart';
import '../../../../core/theme_helper/app_styles.dart';
import '../../../../global_widgets/shared/my_appbar.dart';
import '../../../../global_widgets/ui.dart';
import '../controllers/language_controller.dart';

class LanguageView extends GetView<LanguageController> {
  final bool hideAppBar;

  LanguageView({Key? key, this.hideAppBar = false}) : super(key: key);
  @override
  final controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Ui.myScaffold(
        child: ListView(
      primary: true,
      children: [
        myAppBar2(title: AppStrings.changeLanguage),
        Column(
          children: List.generate(controller.languages.length, (index) {
            var lang = controller.languages.elementAt(index);
            bool selected = lang == Get.locale.toString();

            return Container(
              // height: 80.h,
              margin: EdgeInsets.symmetric(vertical: 5.h),
              child: Theme(
                data: ThemeData(
                    unselectedWidgetColor: AppColors.primaryColor,
                    fontFamily: AppFonts.mainFontFamily),
                child: RadioListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
                  activeColor: AppColors.white,
                  // selectedTileColor: AppColors.primaryColorGreen,
                  tileColor: selected
                      ? AppColors.primaryColor
                      : AppColors.primaryColorOpacity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.h)),
                  value: lang,
                  groupValue: Get.locale.toString(),
                  onChanged: (value) {
                    controller.updateLocale(value);
                  },
                  title: Text(lang.tr,
                      style: selected
                          ? AppStyles.whiteStyle(bold: true)
                          : AppStyles.primaryStyle(bold: true)),
                ),
              ),
            );
          }).toList(),
        )
      ],
    ));
  }
}
