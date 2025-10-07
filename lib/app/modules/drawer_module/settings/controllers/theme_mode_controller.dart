import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/theme_helper/app_themes.dart';
import '../../../../data/constants/app_boxes_names.dart';

class ThemeModeController extends GetxController {
  final selectedThemeMode = ThemeMode.light.obs;
  late GetStorage appThemeModeBox = GetStorage();
  late GetStorage appCurrentThemeBox = GetStorage();

  @override
  void onInit() {
    initThemeMode();
    super.onInit();
  }

  initThemeMode() async {
    String? themeMode = appThemeModeBox.read(
      AppBoxesNames.themeBoxMode,
    );

    if (themeMode != null) {
      switch (themeMode) {
        case 'ThemeMode.light':
          selectedThemeMode.value = ThemeMode.light;
          break;
        case 'ThemeMode.dark':
          selectedThemeMode.value = ThemeMode.dark;
          break;
        case 'ThemeMode.system':
          selectedThemeMode.value = ThemeMode.system;
          break;
        default:
          selectedThemeMode.value = ThemeMode.system;
      }
    } else {
      themeMode = 'ThemeMode.light';
    }
  }

  void changeThemeMode(themeMode) {
    //Get.changeThemeMode(themeMode);

    selectedThemeMode.value = themeMode;
    appThemeModeBox.write(AppBoxesNames.themeBoxMode, themeMode.toString());
    if (themeMode == ThemeMode.light) {
      Get.changeTheme(AppThemes.lightTheme);
      //  Get.changeThemeMode(ThemeMode.light);

      appCurrentThemeBox.write(AppBoxesNames.currThemeKey, 'Light');
    } else
    //if(themeMode==ThemeMode.dark)
    {
      Get.changeTheme(AppThemes.darkTheme);
      // Get.changeThemeMode(ThemeMode.dark);

      appCurrentThemeBox.write(AppBoxesNames.currThemeKey, 'Dark');
    }
    //  Get.changeThemeMode(ThemeMode.dark);

    Get.rootController.restartApp();
  }
}
