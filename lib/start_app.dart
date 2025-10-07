import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import 'app/core/language_and_localization/app_language.dart';
import 'app/core/language_and_localization/app_strings.dart';
import 'app/core/language_and_localization/app_translation.dart';
import 'app/core/theme_helper/app_themes.dart';
import 'app/core/theme_helper/theme_helpr.dart';
import 'app/modules/splash_page/splash_screen.dart';
import 'app/routes/app_routes.dart';

class StartMyApp extends StatelessWidget {
  const StartMyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 845.7142857142857),
      minTextAdapt: true,
      builder: (_, c) =>   ToastificationWrapper(child:  GetMaterialApp(
        // useInheritedMediaQuery: true,
        translations: AppTranslation(),
        title: AppStrings.appTitle.tr.capitalizeFirst!,
        locale: Get.find<AppLanguage>().appLocale,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        fallbackLocale: const Locale('en', 'US'),
        theme: Get.find<ThemeHelper>().currentTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.allRoutes,
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        home: const SplashScreen(), //MoreRegisterDetailsScreen(),
      )),
    );
  }
}
