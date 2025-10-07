import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';
import '../../../../core/theme_helper/app_colors.dart';
import '../../../../global_widgets/ui.dart';
import '../controllers/theme_mode_controller.dart';

class ThemeModeView extends GetView<ThemeModeController> {
  final bool hideAppBar;

  ThemeModeView({Key? key, this.hideAppBar = false}) : super(key: key);
  @override
  final controller = Get.put(ThemeModeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Theme Mode".tr,
                  style: AppStyles.primaryStyle(),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
                elevation: 0,
              ),
        body: ListView(
          primary: true,
          children: [
            GetBuilder<ThemeModeController>(builder: (controller) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: Ui.getBoxDecoration(
                    color: Get.isDarkMode
                        ? Get.theme.primaryColor
                        : AppColors.white),
                child: Column(
                  children: [
                    RadioListTile(
                      value: ThemeMode.light,
                      groupValue: controller.selectedThemeMode.value,
                      onChanged: (value) {
                        controller.changeThemeMode(value);
                      },
                      title: Text("Light Theme".tr,
                          style: AppStyles.primaryStyle()),
                    ),
                    RadioListTile(
                      value: ThemeMode.dark,
                      groupValue: controller.selectedThemeMode.value,
                      onChanged: (value) {
                        //   controller.changeThemeMode(value);
                      },
                      title:
                          Text("Dark Theme".tr, style: AppStyles.primaryStyle()),
                    ),
                    // RadioListTile(
                    //   value: ThemeMode.system,
                    //   groupValue: controller.selectedThemeMode.value,
                    //   onChanged: (  value) {
                    //     controller.changeThemeMode(value);
                    //   },
                    //   title: Text("System Theme".tr, style: Get.textTheme.bodyText2),
                    // ),
                  ],
                ),
              );
            })
          ],
        ));
  }
}
