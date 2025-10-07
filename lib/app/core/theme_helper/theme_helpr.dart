import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/constants/app_boxes_names.dart';
import '../../data/eunums/enums.dart';
import 'app_themes.dart';

class ThemeHelper extends GetxController {
  late GetStorage themeBox = GetStorage();
  late GetStorage appThemeModeBox = GetStorage();
  late GetStorage appCurrentThemeBox = GetStorage();

  ThemeData _currentTheme = ThemeData.light();

  ThemeType _themeType = ThemeType.light;

  ThemeData get currentTheme => _currentTheme;

  setUpDb() async {
    await fetchCurrentTheme();
  }

  fetchCurrentTheme() async {
    if (appCurrentThemeBox.read(AppBoxesNames.currThemeKey) == null) {
      _currentTheme = AppThemes.lightTheme;
      return;
    } else {
      if (appCurrentThemeBox.read(AppBoxesNames.currThemeKey) == 'Light') {
        _currentTheme = AppThemes.lightTheme;
        _themeType = ThemeType.light;
        return;
      }
      if (appCurrentThemeBox.read(AppBoxesNames.currThemeKey) == 'Dark') {
        _currentTheme = AppThemes.darkTheme;
        _themeType = ThemeType.dark;
        return;
      }
    }
  }

  toggleTheme() async {
    if (_themeType == ThemeType.dark) {
      _currentTheme = AppThemes.lightTheme;
      _themeType = ThemeType.light;
      themeBox.write(AppBoxesNames.currThemeKey, 'Light');
      Get.changeTheme(currentTheme);
      return update();
    }

    if (_themeType == ThemeType.light) {
      _currentTheme = AppThemes.darkTheme;
      _themeType = ThemeType.dark;
      themeBox.write(AppBoxesNames.currThemeKey, 'Dark');
      Get.changeTheme(currentTheme);
      return update();
    }
  }
}
