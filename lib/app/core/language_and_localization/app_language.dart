import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum CurrentLang {
  ar,
  en,
}

const String languageCodeKey = 'languageCode';

class AppLanguage extends GetxService {
  // AppLanguage._();

  late Locale _appLocale;

  Locale get appLocale => _appLocale;

  set appLocale(Locale value) {
    _appLocale = value;
    Get.updateLocale(value);
  }

  late CurrentLang currentLang;
  late String currentLangName;

  // //set locale arabic at all
  // Locale get appLocale => Locale('ar');

  late GetStorage appLangBox = GetStorage();

  // @override
  // onInit() async {
  //   super.onInit();
  //   await setUpDB();
  // }

  setUpDB() async {
    //appLangBox = await Hive.openBox(AppBoxesNames.appLangBoxName);
    await fetchLocale();
  }

  fetchLocale() async {
    if (appLangBox.read(languageCodeKey) == null) {
      const String defaultLocale = 'ar';

      if (defaultLocale.contains('ar')) {
        _appLocale = const Locale('ar');
        currentLang = CurrentLang.ar;
        currentLangName = 'العربية';
        return Get.updateLocale(appLocale);
      }

      _appLocale = const Locale('en');
      currentLang = CurrentLang.en;
      currentLangName = 'English';
      Get.updateLocale(appLocale);
      return Null;
    }

    if (appLangBox.read(languageCodeKey).toString().contains('en')) {
      currentLang = CurrentLang.en;
      currentLangName = 'English';
    }

    if (appLangBox.read(languageCodeKey) == 'ar') {
      currentLang = CurrentLang.ar;

      currentLangName = 'العربية';
    }
    _appLocale = Locale(appLangBox.read(languageCodeKey) ?? 'ar');
    Get.updateLocale(appLocale);
    return Null;
  }

  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }

    if (type == const Locale('ar')) {
      currentLang = CurrentLang.ar;
      currentLangName = 'العربية';
      appLocale = const Locale('ar');
      appLangBox.write(languageCodeKey, 'ar');
    } else {
      currentLang = CurrentLang.en;
      currentLangName = 'English';
      appLocale = const Locale('en');
      appLangBox.write(languageCodeKey, 'en');
    }
  }
}
