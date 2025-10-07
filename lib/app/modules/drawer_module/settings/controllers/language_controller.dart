import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  late GetStorage appLangBox = GetStorage();

  setUpDB() async {}

  LanguageController() {
    setUpDB();
  }

  final languages = [
    'en',
    // 'es',
    'ar',
  ];

  void updateLocale(value) async {
    if (value.contains('_')) {
      // en_US
      Get.updateLocale(
          Locale(value.split('_').elementAt(0), value.split('_').elementAt(1)));
    } else {
      // en
      Get.updateLocale(Locale(value));
    }
    await appLangBox.write('languageCode', value);
    // if (Get.isDarkMode) {
    //   Get.find<ThemeModeController>().changeThemeMode(ThemeMode.light);
    // }
    // Get.rootController.setTheme(Get.find<SettingsService>().getLightTheme());
  }
}
