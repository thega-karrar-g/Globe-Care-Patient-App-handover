import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:globcare/app/core/theme_helper/app_styles.dart';

import '../../core/language_and_localization/app_strings.dart';

class NoConnectionSnackBar {
  NoConnectionSnackBar._();

  static late NoConnectionSnackBar? _instance;

  static NoConnectionSnackBar get instance =>
      _instance ??= NoConnectionSnackBar._();

  final GetSnackBar _getBar = GetSnackBar(
    // message: AppLanguage.currentLang == CurrentLang.ar
    //     ? 'يرجى التاكد من اتصالك بالانترنت'
    //     : 'Please Check Your Internet Connection',
    // backgroundColor: Get.theme.primaryColor,
    messageText: Text(
      AppStrings.checkInternet.tr.capitalizeFirst!,
      style: AppStyles.primaryStyle(
        // color: Get.textTheme.subtitle1!.color,
      ),
    ),
    isDismissible: true,
    //dismissDirection: SnackDismissDirection.HORIZONTAL,
  );

  GetSnackBar get getBar => _getBar;

  showNoConnectionSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
    getBar.show();
  }

  static hideNoConnectionSnackBar() {
    if (Get.isSnackbarOpen) {
      Get.back();
    }
  }
}
