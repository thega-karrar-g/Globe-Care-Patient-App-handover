class AppFonts {
  AppFonts._();

  static const String mainFontFamily = 'Almarai';
  static const String shamelFamily = 'FFShamelFamily';
  static const String poppins = 'Poppins';

  static String get appCurrentFont {
    // if (AppLanguage.currentLang == CurrentLang.ar) {
    //   return ma;
    //   }
    // return shamelFamily;
    return mainFontFamily;
  }
}
